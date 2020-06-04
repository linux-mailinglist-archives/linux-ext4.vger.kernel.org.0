Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FB1EDC0A
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jun 2020 06:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgFDEEP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Jun 2020 00:04:15 -0400
Received: from sonic317-33.consmr.mail.ne1.yahoo.com ([66.163.184.44]:39256
        "EHLO sonic317-33.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725861AbgFDEEO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Jun 2020 00:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591243453; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=fzrrUzM64ShhHrHGSe9IAs90d20M0XNvNH9clLSNfKAPB4OlDygAa+/OxsMY92FM7qLLErKL/UOOb9EDTdfyjv2KPQro5xDOu5N30WtjtSQAR8dWttut6fRYIBoZUAQPku9OS88CVqkoLqbt0QRnbw2Mp9MwyJueMCwwfZLR/27gmlgJ34NUuqGszqNftedpewUVhTPFOrXUgSNoZEozTfameax8ET8QssrJ2u+GxVCWRpIPuTi+0ovZPiFaCy9RWwNE82LJ3TEcngQqQyuH95ZErXx3fa/PiD6JBhJH8edZuo7KwE4L9a0BWwsvgtn9DirR1C++jESahJIYfHzObg==
X-YMail-OSG: m95dJDQVM1nZLjgWRsi6eHGj2NfhZxiLJrqSqjCSwZCyMREWnZN2Nevn7hGECpt
 W55lsm._G2X5quG4wcoQL8LzMws0X92HEjT1.qeP72bISxwcK4ngJEKuIlZu4f4qrK0..Bk3_XQp
 X.skVB41zwhLZ7XXODu8JMdCXAb6L8Iq4mSZpq1wzGeEqL7TyGOrU35rI2ZRkoEowEfYq.v2GHZu
 b2zSXXcq3JOOBAbPz6MDTvNqFTNThBLNd230VIqsJmNG0QsXuY51lmebzzcwsIh.jSa3kOmF3yEi
 eUpe6X_yRswfHuoVLWF1bxkiyBYDze73NL94RsCfKFAVLRKvPrCD83GULAOoQM7wjYX9fh9.Rwhf
 g.Pg_ZGR3o807xUbPnlL9TS7ZPW5dmpGq8tJQc9NiYuIGW4FdbJolWoYtfhfV7dUMbUAY1cRnaYb
 6_9YEshCmsNkiXCVkxIpZrg3xNSbUOv8bHnr4MWnM3TX.WJzu9l69oMur5d5d9qf6wS.r0_uO.G2
 x3uOJyzB8sS3gKL75W9sATG6NPxF8cMzYVUZHg0Ur5jEWbgLQ2xdUzjf5uVh7cmD9aFhhJ84fBCc
 A0wrGdKlYFA__FrBY9gKgIzdr6gmmNBsqANtg3wy1F_tWe_HJDzhlz74SlsVcjOjg2f3azyId_P9
 xb3A2MH7Tps8Y0EjQA.4k4h8Ej5yDIAxUbhwQeDtp1lou.qk12ZRdVKTmqlo4PavrINemFqMaOvx
 i6dyz0tSii2hv6J44CRbozXnQf7TWkLLu7hFysDvoi5LW787HU5iJE0rM3dXnM36tJBj75wofsXz
 sCrs1bFFKxp_Xn3NFh4dO3mHHiPifwuel6qyo9CkHaDPJZY1uZZsLU2QUz3NjsDMtq5nr5bkuCfk
 ww7r_vrgbaCpDxNI1oVdjGctulKKtZlKqXdN2u_BRfuEVJruLnxVRYznbnMHJyjERajowpJjUc5H
 CbbzFOrmR5yypSOwwQz98s8aQLO7D0uEH_nf0djFKNA7bmeBe.Ap3NKJrX1.lzFC7v0s0f08KUCl
 YiDiMai.Xdlw8Y3y9PVb3EMSvY6uqbK8YjWf0IrfXsVrOEcOX9XIRcdR1JNFGM88XlU0OBZg0V_9
 bYV7M5PTepix8HgBnRiBXto_2w.MFC1Ld50KNq9U6iSMvkkApp2U60Fnd6lXeQQzXJnW4Ud2s7X7
 EmO.SXDOJ0VuowWbvlt4Yr65v2JXO2_l_v7shQPw9hajXoLmKdC1sf1Tcls4ace5PvvM8f2IQ7v3
 KqLnIFuAEYWLzfv3YT54c65xkrEdkCQFGmLaZEkdwJZUJ45CRawnY.lPFeET9rNWt0XjcKhgfhak
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 4 Jun 2020 04:04:13 +0000
Date:   Thu, 4 Jun 2020 04:04:10 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunel2@gmail.com>
Reply-To: smrsminaabrunel63@gmail.com
Message-ID: <759497937.2473485.1591243450092@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <759497937.2473485.1591243450092.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
