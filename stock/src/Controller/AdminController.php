<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Repository\UserRepository;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use App\Repository\SignatureRepository;
use App\Repository\LogoRepository;
use Symfony\Component\HttpFoundation\Request;
use Knp\Component\Pager\PaginatorInterface;
use Knp\Component\Pager\Pagination\PaginationInterface;
use Knp\Component\Pager\Pagination\SlidingPagination;
use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Mailgun\Mailgun;
use Symfony\Component\Uid\Uuid;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use DateTime;
use App\Entity\Logo;

class AdminController extends AbstractController
{
    #[Route('/admin', name: 'admin_dashboard')]
    /**
     * @Route("/admin", name="admin_dashboard")
     */
    public function adminHome(Request $request, UserRepository $userRepository, SessionInterface $session, UrlGeneratorInterface $urlGenerator, SignatureRepository $signatureRepository, LogoRepository $logo, PaginatorInterface $paginator)
    {
        if (!$session->has('user_id')) {
            return new RedirectResponse($urlGenerator->generate('app_home'));
        }

        $userId = $session->get('user_id');

        if ($userId) {
            $user = $userRepository->find($userId);

            if ($user && $user->getRole() !== 'admin') {
                throw $this->createAccessDeniedException('Access Denied');
            }
        } else {
            throw $this->createAccessDeniedException('Access Denied');
        }

        $createAt = $request->query->get('date');
        $name = $request->query->get('nom');
        $mail = $request->query->get('email');
        // Récupérer les signatures de l'utilisateur connecté
        $page = $request->query->getInt('page', 1);
        // Nombre d'éléments par page
        $itemsPerPage = 5;
        // Récupérer toutes les signatures avec les conditions de recherche
        $signatureQuery = $signatureRepository->createQueryBuilder('s');

        if ($createAt) {
            $startDate = new \DateTime($createAt);
            $endDate = clone $startDate;
            // Ajouter 1 jour à la date de fin pour inclure les signatures du jour de fin
            $endDate->modify('+1 day');

            $signatureQuery->andWhere('s.createAt >= :startDate')
                ->andWhere('s.createAt < :endDate')
                ->setParameter('startDate', $startDate)
                ->setParameter('endDate', $endDate);
        }

        if ($name) {
            $signatureQuery->andWhere('LOWER(s.name) LIKE LOWER(:nom)')
                ->setParameter('nom', '%' . $name . '%');
        }

        if ($mail) {
            $signatureQuery->andWhere('LOWER(s.email) LIKE LOWER(:email)')
                ->setParameter('email', '%' . $mail . '%');
        }
        $allSignatureQuery = $signatureQuery->getQuery();

        // Paginer les signatures
        /** @var PaginationInterface|SlidingPagination $pagination */
        $pagination = $paginator->paginate(
            $allSignatureQuery,
            $page,
            $itemsPerPage
        );



        $users = $userRepository->findAll();
        $allSignatures = $signatureRepository->findAll();

        return $this->render('admin/home.html.twig', [
            'users' => $users,
            'signatures' => $allSignatures,
            'pagination' => $pagination,
            'createAt' => $createAt,
            'name' => $name,
            'mail' => $mail,
        ]);
    }

    #[Route('/admin/users', name: 'admin_index', methods: ["GET"])]
    /**
     * @Route("/admin/users", name="admin_index", methods={"GET"})
     */
    public function index(UserRepository $userRepository, SessionInterface $session, UrlGeneratorInterface $urlGenerator)
    {
        if (!$session->has('user_id')) {
            return new RedirectResponse($urlGenerator->generate('app_home'));
        }

        $userId = $session->get('user_id');

        if ($userId) {
            $user = $userRepository->find($userId);

            if ($user && $user->getRole() !== 'admin') {
                throw $this->createAccessDeniedException('Access Denied');
            }
        } else {
            throw $this->createAccessDeniedException('Access Denied');
        }

        $users = $userRepository->findAll();

        return $this->render('admin/index.html.twig', [
            'users' => $users,
        ]);
    }

    #[Route('/admin/user/delete/{id}', name: 'user_delete', methods: ['POST'])]
    /**
     * @Route("/admin/user/delete/{id}", name="user_delete", methods={"POST"})
     */
    public function delete(Request $request, User $userToDelete, EntityManagerInterface $entityManager, SessionInterface $session, UserRepository $userRepository, UrlGeneratorInterface $urlGenerator)
    {
        if (!$session->has('user_id')) {
            return new RedirectResponse($urlGenerator->generate('app_home'));
        }

        $adminId = $session->get('user_id');

        if ($adminId) {
            $adminUser = $userRepository->find($adminId);

            if ($adminUser && $adminUser->getRole() !== 'admin') {
                throw $this->createAccessDeniedException('Access Denied');
            }
        } else {
            throw $this->createAccessDeniedException('Access Denied');
        }

        $entityManager->remove($userToDelete);
        $entityManager->flush();

        return $this->redirectToRoute('admin_index');
    }

    #[Route('/admin/user/add', name: 'admin_add', methods: ['GET', 'POST'])]
    /**
     * @Route("/admin/user/add", name="admin_add", methods={"GET","POST"})
     */
    public function add(UserRepository $userRepository, Request $request, EntityManagerInterface $entityManager, SessionInterface $session, UrlGeneratorInterface $urlGenerator)
    {
        if (!$session->has('user_id')) {
            return new RedirectResponse($urlGenerator->generate('app_home'));
        }

        $userId = $session->get('user_id');

        if ($userId) {
            $user = $userRepository->find($userId);

            if ($user && $user->getRole() !== 'admin') {
                throw $this->createAccessDeniedException('Access Denied');
            }
        } else {
            throw $this->createAccessDeniedException('Access Denied');
        }

        $user = new User();
        $defaultPassword = "unsa_white_knight_pass_word_very_long";

        $form = $this->createFormBuilder($user)
            ->add('email', EmailType::class)
            ->add('password', HiddenType::class, [
                'data' => $defaultPassword,
            ])
            ->add('role', ChoiceType::class, [
                'choices' => [
                    'Utilisateur' => 'utilisateur',
                    'Admin' => 'admin'
                ],
            ])
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {

            $email = $user->getEmail();
            $existingUser = $entityManager->getRepository(User::class)->findOneBy(['email' => $email]);
            if ($existingUser) {
                $session = new Session();
                $session->getFlashBag()->add('danger', 'L\'adresse e-mail est déjà utilisée.');
                return $this->render('admin/add.html.twig', [
                    'form' => $form->createView(),
                ]);
            }
            $hashedPassword = password_hash($user->getPassword(), PASSWORD_DEFAULT);
            $user->setPassword($hashedPassword);

            $token = Uuid::v4();
            $tokenExpiration = new DateTime();
            $tokenExpiration->modify('+24 hours');

            $tokenWithExpiration = $token . '-' . str_replace([' ', ':'], '-', $tokenExpiration->format('d-m-Y H:i:s'));

            $user->setToken($tokenWithExpiration);


            $entityManager->persist($user);
            $entityManager->flush();

            //configurer mon server smtp pcq mailgun c'est pas fou
            $mgClient = Mailgun::create('9ce219b17ec2b8a27138b5099a79c392-07ec2ba2-8a4b0c3b');

            $domain = "sandbox2d5e1ea5fe7e445e9e7b8488a8c33c2a.mailgun.org";
            $params = [
                'from'    => 'mohammed-el-amine.djellal@epitech.eu',
                'to'      => $email,
                'subject' => 'Création de compte',
                'text'    => 'Veuillez cliquer sur le lien suivant pour créer votre mot de passe : ' . $this->generateUrl('create_password', ['token' => $user->getToken()], UrlGeneratorInterface::ABSOLUTE_URL),
            ];

            $mgClient->messages()->send($domain, $params);

            $this->addFlash('success', 'L\'ajout d\'un nouvelle utilisateur a été effectué avec succès.Un e-mail vient de lui être envoyer pour crée son mot de passe');
        }

        return $this->render('admin/add.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    #[Route('user/create-password/{token}', name: 'create_password', methods: ['GET', 'POST'])]
    public function createPassword(Request $request, EntityManagerInterface $entityManager, string $token)
    {
        $user = $entityManager->getRepository(User::class)->findOneBy(['token' => $token]);

        if (!$user) {
            throw $this->createNotFoundException('Utilisateur non trouvé');
        }

        // if (!$user->isTokenValid()) {
        //     return $this->redirectToRoute('app_home');;
        // }

        $form = $this->createFormBuilder($user)
            ->add('password', RepeatedType::class, [
                'type' => PasswordType::class,
                'invalid_message' => 'Les champs du mot de passe doivent correspondre.',
                'options' => ['attr' => ['class' => 'password-field']],
                'required' => true,
                'first_options' => ['label' => 'Nouveau mot de passe'],
                'second_options' => ['label' => 'Confirmer le mot de passe'],
            ])
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $newPassword = $form->get('password')->getData();
            $hashedPassword = hash('sha256', $newPassword);

            $user->setPassword($hashedPassword);
            $user->setToken(null);

            $entityManager->flush();

            return $this->redirectToRoute('app_home');
        }

        return $this->render('password/create_password.html.twig', [
            'form' => $form->createView(),
            'user' => $user
        ]);
    }

    #[Route('/admin/user/edit/{id}', name: 'utilisateur_edit', methods: ['GET', 'POST'])]
    /**
     * @Route("/admin/user/edit/{id}", name="utilisateur_edit", methods={"GET","POST"})
     */
    public function edit(User $editUser, Request $request, EntityManagerInterface $entityManager, SessionInterface $session, UserRepository $userRepository, UrlGeneratorInterface $urlGenerator)
    {
        if (!$session->has('user_id')) {
            return new RedirectResponse($urlGenerator->generate('app_home'));
        }

        $userId = $session->get('user_id');

        if ($userId) {
            $currentUser = $userRepository->find($userId);

            if ($currentUser && $currentUser->getRole() !== 'admin') {
                throw $this->createAccessDeniedException('Access Denied');
            }
        } else {
            throw $this->createAccessDeniedException('Access Denied');
        }

        $currentEmail = $editUser->getEmail();
        $currentRole = $editUser->getRole();
        $currentPassword = $editUser->getPassword();

        $form = $this->createFormBuilder($editUser)
            ->add('email', EmailType::class, [
                'data' => $currentEmail,
            ])
            ->add('password', PasswordType::class, [
                'required' => false,
                'empty_data' => '',
            ])
            ->add('role', ChoiceType::class, [
                'choices' => [
                    'Admin' => 'admin',
                    'Utilisateur' => 'utilisateur',
                ],
                'data' => $currentRole,
            ])
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $editUser->setEmail($currentEmail);
            $editUser->setRole($currentRole);

            $newRole = $form->get('role')->getData();
            $editUser->setRole($newRole);

            $newPassword = $editUser->getPassword();

            if (!empty($newPassword)) {
                $hashedPassword = hash('sha256', $newPassword);
                $editUser->setPassword($hashedPassword);
            } else {
                // Aucun nouveau mot de passe fourni, on ne l'actualise pas
                $editUser->setPassword($currentPassword);
            }

            $entityManager->flush();

            $this->addFlash('success', 'L\'enregistrement a été effectué avec succès.');
        }
        return $this->render('admin/edit.html.twig', [
            'form' => $form->createView(),
            'user' => $editUser,
        ]);
    }

    #[Route('/admin-logo', name: 'admin_logo', methods: ['GET', 'POST'])]
    /**
     * @Route("/admin/logo", name="admin_logo", methods={"GET","POST"})
     */
    public function logo(Request $request, EntityManagerInterface $entityManager, SessionInterface $session, UserRepository $userRepository, UrlGeneratorInterface $urlGenerator)
    {
        if (!$session->has('user_id')) {
            return new RedirectResponse($urlGenerator->generate('app_home'));
        }
        $userId = $session->get('user_id');

        if ($userId) {
            $currentUser = $userRepository->find($userId);

            if ($currentUser && $currentUser->getRole() !== 'admin') {
                throw $this->createAccessDeniedException('Access Denied');
            }
        } else {
            throw $this->createAccessDeniedException('Access Denied');
        }
        $currentDateTime = new \DateTimeImmutable();

        $logo = new Logo();
        $logo->setCreateAt($currentDateTime);
        $logo->setUpdateAt($currentDateTime);
        
        $form = $this->createFormBuilder($logo)
            ->add('name', TextType::class, [
                'label' => 'Nom :',
                'required' => true,
                'attr' => ['placeholder' => 'Nom du logo'],

            ])
            ->add('path', TextType::class, [
                'label' => 'Chemin du logo :',
                'required' => true,
                'attr' => ['placeholder' => '/path/to/logo.png'],

            ])
            ->add('submit', SubmitType::class, [
                'label' => 'Ajouter',
                'attr' => ['class' => 'btn btn-primary'],
            ])
            ->getForm();

            $form->handleRequest($request);
    
            if ($form->isSubmitted() && $form->isValid()) {
                $entityManager->persist($logo);
                $entityManager->flush();
                
                $this->addFlash('success', 'Le logo a été ajouté avec succès.');
                return $this->redirectToRoute('admin_logo');
            }

            $logoRepository = $entityManager->getRepository(Logo::class);
            $logos = $logoRepository->findAll();
            
            return $this->render('admin/logo.html.twig', [
                'form' => $form->createView(),
                'logos' => $logos,
            ]);
    }

    #[Route('/admin/create-signature', name: 'admin_create_signature', methods: ['GET', 'POST'])]
    /**
     * @Route("/admin/create-signature", name="admin_create_signature", methods={"GET","POST"})
     */
    public function createSignature(Request $request, EntityManagerInterface $entityManager, SessionInterface $session, UserRepository $userRepository, UrlGeneratorInterface $urlGenerator)
    {
        
    }
}
