Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE2664487D
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 16:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiLFP7z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 10:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbiLFP7y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 10:59:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4E7240AF
        for <linux-ext4@vger.kernel.org>; Tue,  6 Dec 2022 07:59:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bs21so24122444wrb.4
        for <linux-ext4@vger.kernel.org>; Tue, 06 Dec 2022 07:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NgRHXVnEISkXMqWfVgd9bPaNDbTrsT8BuxpGskPtjc=;
        b=cCOp+NyYHphlNFtmbHMSX+zOh1PsCtB2UjVSsMzhAOTOx4kTqaHNK6Ilmt9hqTgSJS
         xwwocXjriG0ZgCsIrtGDuIAiJeLFD8HdYjX0IG6z89cBN6L2nkQZmElrGyojIoNF2Hui
         r6Qo81norDj1TrOjl3gFqVWZsDsZHO3jaAIKM5t/+NfmsBHW77UfK8N3p4xHTAIejvRS
         IKkrQiWyRtxrAy+7y7ZareL4gNZxJoF3AHcTsvCpyzp3xjBmQEdei5nC1bTltwcB46wo
         bR/VmnV68DeaqjtPDqyBW3KjiwlQVySGs/RZFixSHySFoCXAuGnKS4INX+7aX/xtShyt
         YDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NgRHXVnEISkXMqWfVgd9bPaNDbTrsT8BuxpGskPtjc=;
        b=tMYjOoBKsADkVzOFClBYNcgdqita/cFXIFQ/3XTpXy+/FLbVwvkgpeIXWEv0w5npqI
         zs37AAg9fUtp73yTzNdBkJs5FyhURuCjcRuMmlvBd1s6Fjgns8VmBuIPPG7Af3OWBMrH
         QQaYtiMkl3uUQB6gkv7KXpNMCrzJ6HI4ANqNNZBgstY9Gufr6afuRGa36tq7BK/CisJL
         UAOUo1F7eBPrfDzYJDNjF51q1BLZEDpgzCAhBf0oJsOcyUJs9K4otmC+YKxg30YyJXZe
         jS7lfxpRn6VsEC6ZiXVquVGtQXmP2z6rJipjvOn5TT36ogBYw54LE9+hY09gInSkXtcz
         GvgA==
X-Gm-Message-State: ANoB5pmivvc+vbjZNGY5o6wnJHUiJ6lrJ8mKzm3bDvxdaIS+4TLc7tYd
        p1KuApHQq3EIok1sw263+9COjGmrf0GL3toUmvo=
X-Google-Smtp-Source: AA0mqf6+3aPGDrs4xVihlkcp0LMifhJ1gv7ySX3xfRErx7LEYDSKHuOfewhPpnGdqqEdNzB68AQt/a3ivBQH46adzc4=
X-Received: by 2002:adf:eb8a:0:b0:22e:31b2:ecb9 with SMTP id
 t10-20020adfeb8a000000b0022e31b2ecb9mr54467824wrn.693.1670342376191; Tue, 06
 Dec 2022 07:59:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:5450:0:0:0:0:0 with HTTP; Tue, 6 Dec 2022 07:59:35 -0800 (PST)
Reply-To: halabighina00@gmail.com
From:   Ghina Halabi <kangnasougle0@gmail.com>
Date:   Tue, 6 Dec 2022 15:59:35 +0000
Message-ID: <CAF396ZOt=R87veQF4jRYndrT2E5vb8tftz-VxfCiDUWej9rqaA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

-- 
Hello good day,I am happy to be together with you, My name is Ghina
Halabi, I am a military nurse working with  Israeli defense force.
Please don't let my profession, race or nationality enter your mind,
there is something very important which I would like us to discuss.Can
we talk about friendship and partnership? please if you really want to
have a good and prosperous communication with me please kindly respond
to me positively.
