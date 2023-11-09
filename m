Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DEF7E6D2D
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Nov 2023 16:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjKIPUK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Nov 2023 10:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjKIPUJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Nov 2023 10:20:09 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB1730DC
        for <linux-ext4@vger.kernel.org>; Thu,  9 Nov 2023 07:20:06 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a640c23a62f3a-9e1fb7faa9dso168083366b.2
        for <linux-ext4@vger.kernel.org>; Thu, 09 Nov 2023 07:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699543205; x=1700148005; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Il4H/TuFzygCaDoxUJPgQM4MSHSP5zuggLcYTsBKlKE=;
        b=M15A5dLXc0FRft5kYPAUzjarkBbfipgzmD2xXSzQQmTe9t4+PTED2nW1IdmLLE3QtM
         Y+scKQ4sfHW+ofkLi7Pg7VFyMiy5zD1RXP/LCxX6paEKEppNcU5rDTVIZKEcCb1pA+59
         FtcsDHHSQ34/Rm4kxmiJ8gTg6wPPqvuecxrOm1sNSX5kTreh6evvv6PWG5Rbna8dCePm
         NwQH6lC3XNgQpwSb7KKFMN1ety13hnbyzgK1LoqvoRH9I7pp8rgWAEO3jaC2qwjYpjCM
         +S25VsIMpm/cGyQPeK2Llv2LW/sfOzh1Ukww4jSyL0tw9F0+sFb4OOjFGjF1c0E8FiHU
         fz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543205; x=1700148005;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Il4H/TuFzygCaDoxUJPgQM4MSHSP5zuggLcYTsBKlKE=;
        b=Q8GfHs2p9KUGfPgozGbomycLMIq17duwhR4suiqjmMidW3mfYczqPz5PrIJGuj0hjO
         suazZVI4M6xFNlnO+/dEyWJnELTUPE8S3Dy56E9u09wXdSc9X/5FPJvzARla5Yv8tQ78
         JaSfXUsPSQO9s6qLTq+fCtIF5WjTOhoWosDagvy0sPJVgmwkuoYMPzRm7VP832t0A2Ef
         XIJ/hbj1lStnKY1ui446oP6nFsBvVDZ0+HSnoAnU9B0LuJ0+p7R15BURygDRZHjbibY/
         UAlsN/HPvKAWZ/pkSPepCEfDgOYwYhlxmxWY1byEQLSIC1wk/JOXsUHe+CmrqAJ2sfyL
         Im6w==
X-Gm-Message-State: AOJu0YywVaHFluFKxfn/zjfzNrlLEsM+6yqoHyP3WVZQqfabyNxLUfVV
        1WPrl3vM1W58B1CknfD9l/QDhZWLgUpXQgm3/uc=
X-Google-Smtp-Source: AGHT+IHO2QHBHAWDHwrX+iSgxZt5W8jERVmRwhZbqMgsDxgFsw6DLHqAMqbqRXhboGvciML/mu3wyqDW0KkBZg0GNUE=
X-Received: by 2002:a17:907:96a3:b0:9cf:36be:3b5d with SMTP id
 hd35-20020a17090796a300b009cf36be3b5dmr4320296ejc.61.1699543204814; Thu, 09
 Nov 2023 07:20:04 -0800 (PST)
MIME-Version: 1.0
Sender: brianphilippe50@gmail.com
Received: by 2002:a05:7208:21cc:b0:6d:9d74:68f9 with HTTP; Thu, 9 Nov 2023
 07:20:04 -0800 (PST)
From:   Stepan CHERNOVETSKY <s.chernovetskyi@gmail.com>
Date:   Thu, 9 Nov 2023 16:20:04 +0100
X-Google-Sender-Auth: uUBY-VPoYsYa4I1i7PJPzM3WWwE
Message-ID: <CAGvUTU8FE6ocC-8Z5nDxJuDJdMpJ-bj+GZPDtz0M_ULpkJq=Kw@mail.gmail.com>
Subject: Inquiry for an investment
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear Sir/Madam,

Please do not be embarrassed for contacting you through this medium; I
got your contact from Google people search and then decided to contact
you. My goal is to establish a viable business relationship with you
there in your country.

I am CHERNOVETSKYI Stepan, from Kyiv (Ukraine); I was a businessman,
Investor and Founder of Chernovetskyi Investment Group (CIG) in Kyiv
before Russia=E2=80=99s Invasion of my country. My business has been destro=
yed
by the Russian military troops and there are no meaningful economic
activities going on in my country.

I am looking for your help and assistance to buy properties and other
investment projects, I consider it necessary to diversify my
investment project in your country, due to the invasion of Russia to
my country, Ukraine and to safeguard the future of my family.

Please, I would like to discuss with you the possibility of how we can
work together as business partners and invest in your country through
your assistance, if you can help me.

Please, if you are interested in partnering with me, please respond
urgently for more information.


Yours Sincerely,
CHERNOVETSKYI Stepan.
Chairman / CEO - Chernovetskyi Investment Group (CIG)
