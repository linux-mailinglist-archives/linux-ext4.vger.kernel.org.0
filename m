Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028F34E8E45
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Mar 2022 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiC1GlV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Mar 2022 02:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbiC1GlU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Mar 2022 02:41:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8BC1137
        for <linux-ext4@vger.kernel.org>; Sun, 27 Mar 2022 23:39:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id pv16so26587026ejb.0
        for <linux-ext4@vger.kernel.org>; Sun, 27 Mar 2022 23:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vhRjNi0C92HhLekr+PXsG0jM+VxQU0SbIRkpFEeooUI=;
        b=jg/akFsLf4l4TnPUfiHAsTk7B0h4dygGBJayDXFkwASrxMZJUEea9MeKfqeBnMrYiH
         VrFZXNx2h0Esx4j4DEDPm41XuiAq6c2svPpmepzodmB0/s1L6Z0H1WjPDpvPWi11YMaD
         lhHU2n11scb9/JwFUvsog6OZ/tanNS47lQRd/GhRC4743LKx1KOdK/sj2MaBPisGCNuR
         gkwbMUlg8+S3bw/htucaYMePh+dRLOsjTP4OSISgQmSXgDGZ1F7fne6LmvTfHulQ6VA+
         CPnEi7NTQNzox+6lP2hPagHlqsOLId9fdqHo82r8eF8AbS3CegFJXRpk5M6Pq0WYKF2o
         TCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=vhRjNi0C92HhLekr+PXsG0jM+VxQU0SbIRkpFEeooUI=;
        b=GKuy2wZ9MbW82g4WZGICEgwXXeg8ESb9UbmC7q3Ju+op1s40DsFc+ffEPtyTymJuev
         Oi623qAbzElak9vqtDyDn7tx0+mvd17PGUj4h3kCwPHQ1MB5aGR7BO3BEEZV83snvosA
         6HbHvyny3mQ6hbYCz1z0wxwoRMqE1mBcMM4ujn06oq2GtAi2XvvbHW2sLqBuqApP0gqI
         eB0mffPu+pyNnv1sHgtseR8zfrnUe2IYgxqgxriO480nQ9EL9mjGruvVvup7C81xTpMI
         XkYGClhgc7EXPr1h2FQmBQdbLS3Hb61yWOGS2I98wFUfX7CxR4wlbM+UnyugaEZatWh9
         Yv1Q==
X-Gm-Message-State: AOAM533gEM6ppIwgz/Ht2sa763C+mvPHOrmc+X1qrRQfBBoDZn+d8QjF
        68xJr2oeQ0VekXbMfPz/egO6npVI4YVrSto9FGQ=
X-Google-Smtp-Source: ABdhPJy10YCYZxJh3xVRxmMp49hSQiKUKOdlKFq1RpSJQExzaFUravfPurs4uHrJzoFbBBFsmUSQza2hzoM2b0ZJO2M=
X-Received: by 2002:a17:907:7ea8:b0:6df:d4a4:8156 with SMTP id
 qb40-20020a1709077ea800b006dfd4a48156mr26169049ejc.226.1648449579461; Sun, 27
 Mar 2022 23:39:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3b45:0:0:0:0:0 with HTTP; Sun, 27 Mar 2022 23:39:38
 -0700 (PDT)
Reply-To: maria.elisabethschaeffler1940@gmail.com
From:   Maria-Elisabeth Schaeffler <rebeccaefe007@gmail.com>
Date:   Mon, 28 Mar 2022 07:39:38 +0100
Message-ID: <CANMBYZE6OYA73QHTNY8pKVB1-40j2DEwt85s6=1rnuGTattWAQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5060]
        *  0.0 FROM_LOCAL_HEX From: localpart has long hexadecimal sequence
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maria.elisabethschaeffler1940[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rebeccaefe007[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rebeccaefe007[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
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
Maria-Elisabeth Schaeffler
maria.elisabethschaeffler1940@gmail.com
