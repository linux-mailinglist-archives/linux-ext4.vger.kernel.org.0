Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A01C635A9A
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Nov 2022 11:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiKWKxa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Nov 2022 05:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiKWKxM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Nov 2022 05:53:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE885132D
        for <linux-ext4@vger.kernel.org>; Wed, 23 Nov 2022 02:40:13 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 71-20020a17090a09cd00b00218adeb3549so1461240pjo.1
        for <linux-ext4@vger.kernel.org>; Wed, 23 Nov 2022 02:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plu-edu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x9nBZ85SJB5q4CGFyjavqb9az+zehcJOmoZUqwqW1Cg=;
        b=2Rj9AkYSfBikgtX5MBPqG55RKExVe2xTlDK2Y+6WY2v/CEDlf90Ukh+2Sr+Gu5p9zY
         Vc80DHtRgoekz3wLp92Tvj6qgiGJQZ+TVbdN82yS+bm/VgEDaS0L2yGGiFg1e41jMekZ
         AXpgv74MklmSnH/NHfOuE5oD2m67uIehyzMy5InRDWGkMcAcx5w+GLxS7ryZEOzE4ovr
         zBwjdCJZk6St1HPEtwClnW67ZPPQ0Uogt8BanSE41aAmayV3ORWhgIt3Pm5ZIHzeheKo
         3UJeNtbPfMvd5OpLqDWJUwjGJ2amb1CL1APY+a5oxy1FcXDxG2jDnyGAunQJLfi0D65N
         KKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9nBZ85SJB5q4CGFyjavqb9az+zehcJOmoZUqwqW1Cg=;
        b=ndNDNKrD6ruW96H4zqRtiBR9T1H6JjXtsYFCstmT6K8L1g8oApIQyelcfuyiHA4VMn
         1kBqkyCDTjEJL9drrtgZymtd648yuigHd4I3XCH4l8kf4b9CbezBYsjNH1OUHECQYkh3
         7ixJdrPppcZ+re4r+CaSAWbSVN3OJftx9vYrY9DyHSrh+BXJs+AAB03rrOxLPTyUsbCe
         KkhpaSHvZak1nSXzQG2/Kqunk3UUurG/6TP7bCR71EfLf5n9tMHSI5938ivz1ZqYkHxi
         KlroQl6bMclhNlmDQX8px1+Ioz7bBRHwvABH8U12LB6mTpG4TelBi7J6HBSSaVchOkU+
         meww==
X-Gm-Message-State: ANoB5pnfU+7At5kLOfsXcMNYQlJaqcAmpnM+DKT4CcKNKrHMgVF2SVX9
        vJPEffYp5NecSUZ8MJQtSAHnV4/p/DjC7mxyTxSSnpfgkKBcRj6g8kUhfw==
X-Google-Smtp-Source: AA0mqf62c+RHEhAyd0XMHd1i9vI4evCMgO3HUW4wopuDAk38YffpIAP+g8BPWxTsOoVh1JWaQs6SinM83UdDi46d3RU=
X-Received: by 2002:a17:902:b286:b0:186:9cce:c4d with SMTP id
 u6-20020a170902b28600b001869cce0c4dmr21473795plr.103.1669200013173; Wed, 23
 Nov 2022 02:40:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:903:41c6:b0:189:8b3:94e7 with HTTP; Wed, 23 Nov 2022
 02:40:12 -0800 (PST)
Reply-To: maria.elisabethschaeffler1940@gmail.com
From:   Maria-Elisabeth Schaeffler <tillmadm@plu.edu>
Date:   Wed, 23 Nov 2022 02:40:12 -0800
Message-ID: <CAGyBZ5YxJhPi1uQikoGORAcRMNcrB2_j3OGhXQLQLvB+A=+NUg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--=20
Hallo,

Sie haben eine laufende Spende von Frau Maria-Elisabeth Schaeffler,
Antworten Sie jetzt f=C3=BCr Details und Anforderungen ..

Herzliche Gr=C3=BC=C3=9Fe
Gesch=C3=A4ftsf=C3=BChrer schaeffler Gruppen
Maria-Elisabeth Schaeffler.
