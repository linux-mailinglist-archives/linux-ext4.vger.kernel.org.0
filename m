Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05C07138C0
	for <lists+linux-ext4@lfdr.de>; Sun, 28 May 2023 10:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjE1IfU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 May 2023 04:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjE1IfT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 May 2023 04:35:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28840BE
        for <linux-ext4@vger.kernel.org>; Sun, 28 May 2023 01:35:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f611ccd06eso14778185e9.0
        for <linux-ext4@vger.kernel.org>; Sun, 28 May 2023 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685262916; x=1687854916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5az4Eu1VAlmeyQAupzgPEaWF28fGzbAd46Z1OgJ9gm4=;
        b=jE2YXyZCgtgHq4UxGsLs+NUUgnc4HrgtKrMvDBozcBuORWzier2RRr/zsNYgyW1Hyz
         AF0TUx9EWb9Gm3wi0XoUD8mcCYdD6/zg1RMDoDNofce/m26dIESRcKhozZv1CZt8rTPm
         qwJI1g0ZgtIVkgFtrOeLI/VGjHnrolikMF1GFaJdMbulukWEfqg6mtxmipcMTrFs+RR6
         iIwZRYvLTZttgLkOKH4YxdkPNMX29EsDsLAujend0EdUB3v7C/lr9+lnOkBRpxuqugi9
         jwrKT626qQEa9T3SS2eE+hXcLtvQdG++8agqMAvH0C4yEmKHvJe4W+UPGyiu3Pj6QGh7
         38Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685262916; x=1687854916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5az4Eu1VAlmeyQAupzgPEaWF28fGzbAd46Z1OgJ9gm4=;
        b=hE6c0NIFozmfNYnizwVaUN/bXFnwtA4lqcBCNn1FGPv+po9lDx+LGQRr0uHlAh2XcK
         SrSnj1oT1QFkVhi4y0KjzScIgq/mr909hTLInGtRLaLdxIMNVCTZe9cB6LtTuzjn9wT4
         7zvyqkmmeaK7uzN4O7NWyXkvbfgYJTwiOomQ5zZawzk88PyCls+HOaEBr00Qb5vie/CH
         oFGQJwph3v+NWq8BCKLCA5PGl64KV1mEeUuFJpfGiRWj7VFtTnl9KX4g2TcKoKo358jO
         VI+28RRYATZrKer0bOJ6C/QGLgwy2Hb2xzRI7bfxn2zdEHJteSdpkVf/SfBRL5fVpnj0
         Joxw==
X-Gm-Message-State: AC+VfDyGGD8+A0uE9fZ5SjS5vb6kkBO0SBXb4UcoplnitptEQPeINSjk
        8mtLQfeeDKIp+pIYpLlC2cX+cHs5fvo=
X-Google-Smtp-Source: ACHHUZ77JWrwgy1mKhA73i+ee/JIGigcTgrhLbUDtE8+aaV9nNP0UWExm63/CuOij62PhEo5yZ8NAQ==
X-Received: by 2002:a7b:ca45:0:b0:3f6:e59:c04c with SMTP id m5-20020a7bca45000000b003f60e59c04cmr6170324wml.24.1685262916288;
        Sun, 28 May 2023 01:35:16 -0700 (PDT)
Received: from torreasustufgamingpro ([213.177.194.118])
        by smtp.gmail.com with ESMTPSA id o5-20020a1c7505000000b003f6f6a6e769sm4016003wmc.17.2023.05.28.01.35.15
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 01:35:15 -0700 (PDT)
From:   =?utf-8?Q?Oscar_Megia_L=C3=B3pez?= <megia.oscar@gmail.com>
To:     linux-ext4@vger.kernel.org
Subject: I know you are busy, but have you found time to look at my patch?
Date:   Sun, 28 May 2023 10:29:12 +0200
Message-ID: <87353gluzr.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

My patch was: e2fsck: Add percent to files and blocks feature.

Do I need to change something or is it not accepted?

Regards
Oscar Megia L=C3=B3pez
