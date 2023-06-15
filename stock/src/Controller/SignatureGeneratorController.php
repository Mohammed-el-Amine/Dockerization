<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TelType;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use DateTimeImmutable;
use App\Entity\Logo;
use App\Entity\Signature;
use App\Repository\UserRepository;
use App\Repository\LogoRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\HttpFoundation\RedirectResponse;

class SignatureGeneratorController extends AbstractController
{
    private $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    #[Route('/signature', name: 'profile_signature')]
    public function generateSignature(Request $request, EntityManagerInterface $entityManager, SessionInterface $session, UrlGeneratorInterface $urlGenerator, UserRepository $userRepository, LogoRepository $logoRepository): Response
    {
        if (!$session->has('user_id')) {
            return new RedirectResponse($urlGenerator->generate('app_home'));
        }

        $userId = $session->get('user_id');

        if ($userId) {
            $user = $userRepository->find($userId);
        } else {
            throw $this->createAccessDeniedException('Access Denied');
        }

        $logos = $logoRepository->findAll();
$logoChoices = [];

foreach ($logos as $logo) {
    $name = $logo->getName();
    $path = $logo->getPath();
    $logoChoices[$name] = $logo;
}

        $form = $this->createFormBuilder()
            ->add('name', TextType::class, [
                'label' => 'Nom et Prénom : ',
                'attr' => [
                    'placeholder' => 'Nom et Prénom',
                ],
            ])
            ->add('role', TextType::class, [
                'label' => 'Rôle : ',
                'attr' => [
                    'placeholder' => 'Poste dans l\'entreprise',
                ],
            ])
            ->add('organization', TextType::class, [
                'label' => 'Organisation : ',
                'attr' => [
                    'placeholder' => 'Nom de l\'entreprise'
                ],
            ])
            ->add('adress', TextType::class, [
                'label' => 'Adresse : ',
                'attr' => [
                    'placeholder' => 'Addresse',
                ],
            ])
            ->add('zip_code', TextType::class, [
                'label' => 'Code postal : ',
                'attr' => [
                    'placeholder' => 'Code Postal',
                ],
            ])
            ->add('city', TextType::class, [
                'label' => 'Ville : ',
                'attr' => [
                    'placeholder' => 'Ville',
                ],
            ])
            ->add('email', EmailType::class, [
                'label' => 'Email : ',
                'attr' => [
                    'placeholder' => 'Email',
                ],
            ])
            ->add('phone', TelType::class, [
                'label' => 'Téléphone : ',
                'attr' => [
                    'placeholder' => 'Tél',
                ],
            ])
            ->add('logo', EntityType::class, [
                'label' => 'Logo : ',
                'class' => Logo::class,
                'choice_label' => 'name',
                'choice_attr' => function ($key) {
                    return ['name' => $key->getPath()];
                },
                'choices' => $logoChoices,
                'required' => false,
            ])
            ->getForm();

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $data = $form->getData();

            // Créer une instance de l'entité Signature et définir les valeurs des propriétés
            $signature = new Signature();
            $signature->setName($data['name']);
            $signature->setRole($data['role']);
            $signature->setOrganization($data['organization']);
            $signature->setAdress($data['adress']);
            $signature->setZipCode($data['zip_code']);
            $signature->setCity($data['city']);
            $signature->setEmail($data['email']);
            $signature->setPhone($data['phone']);
            $signature->setLogo($data['logo']);
            $signature->setUserId($session->get('user_id'));

            $createAt = new DateTimeImmutable();
            $signature->setCreateAt($createAt);

            // Définir la date de mise à jour (identique à la date de création initialement)
            $updateAt = clone $createAt;
            $signature->setUpdateAt($updateAt);

            // Enregistrer l'entité dans la base de données
            $entityManager->persist($signature);
            $entityManager->flush();

            // Générer la signature avec les données fournies
            $generatedSignature = $this->generateEmailSignature($data);


            return $this->render('signature/show_signature.html.twig', [
                'signature' => $generatedSignature,
            ]);
        }

        return $this->render('signature/generate_signature.html.twig', [
            'form' => $form->createView(),
        ]);
    }
    private function generateEmailSignature(array $data): string
    {
        $html = '<!DOCTYPE html>';
        $html .= '<html lang="fr">';
        $html .= '<head>';
        $html .= '<meta charset="utf-8">';
        $html .= '<title>UNSA Signature</title>';
        $html .= '</head>';
        $html .= '<body>';
        $html .= '<table border="0" cellpadding="0" width="500">';
        $html .= '<tbody>';
        $html .= '<tr>';
        $html .= '<td align="left" valign="middle" width="10">';
        $html .= '<p style="padding-right: 10px;font-size: 12px;line-height: 14px;">';
        $html .= '<a href="https://www.unsa.org"><img src="' . $data['logo']->getPath() . '" style="border: none;width: 120px;"></a>';
        $html .= '</p>';
        $html .= '</td>';
        $html .= '<td>';
        $html .= '<p style="font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, \'Helvetica Neue\', Arial, sans-serif;font-size: 12px; line-height: 14px; color: #000;text-align: left;">';
        $html .= '<span style="color: #000;font-weight: bold;font-size: 14px;">' . $data['name'] . '</span><br>';
        $html .= '<span style="color: #666;"><i>' . $data['role'] . '</i></span><br>';
        $html .= '<span style="color: #666;"><i>' . $data['organization'] . '</i></span><br>';
        $html .= '</p>';
        $html .= '<p style="font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, \'Helvetica Neue\', Arial, sans-serif;font-size: 12px; line-height: 14px; color: #000;">';
        $html .= '<span style="color: #000;">' . $data['adress'] . '</span><br>';
        $html .= '<span style="color: #000;">' . $data['zip_code'] . '&nbsp;</span>';
        $html .= '<span style="color: #000;">' . $data['city'] . '</span><br>';
        $html .= '</p>';
        $html .= '<p style="font-family: -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, \'Helvetica Neue\', Arial, sans-serif;font-size: 12px; line-height: 14px; color: #000;">';
        $html .= '<img src="https://reseaux.unsa.org/signature/_mail.svg" style="border: none;height: 12px;margin-right: .5em;">';
        $html .= '<a href="mailto:' . $data['email'] . '" style="color: #666;font-style: italic;">' . $data['email'] . '</a><br>';
        $html .= '<img src="https://reseaux.unsa.org/signature/_phone.svg" style="border: none;height: 14px;margin-right: .5em;">';
        $html .= '<span style="color: #666;">' . $data['phone'] . '</span>';
        $html .= '</p>';
        $html .= '</td>';
        $html .= '</tr>';
        $html .= '</tbody>';
        $html .= '</table>';
        $html .= '</body>';
        $html .= '</html>';

        return $html;
    }

    #[Route('/logout', name: 'logout')]
    /**
     * @Route("/logout", name="logout")
     */
    public function logout(SessionInterface $session, UrlGeneratorInterface $urlGenerator)
    {
        $session->invalidate();
        return new RedirectResponse($urlGenerator->generate('app_home'));
    }
}
