Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF563EA8E
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 08:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiLAHvK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 02:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLAHvJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 02:51:09 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307FC45ECD
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 23:51:07 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3bfd998fa53so9087717b3.5
        for <linux-ext4@vger.kernel.org>; Wed, 30 Nov 2022 23:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TzsECpQQZWszrfGpCKzDzrw8iWPksBCj12PLooJzSsE=;
        b=G/ce4IEuZgq9Rlz5haBq2OX6v9fz9Y4T2e+spL9cvfa0ZOH4nsaze+0H0WFMumMN3k
         5yi1VYORS6oftTw2QB8Cz8MMLxR2VEt/s9B54LVFjjHnlLMZcshBnbXdA6LK0yl+QQpk
         gsLk0TwPK/J8Ral7GUT/oFJ+J0eGeBJcvd8Y12bezdSwybnXikLGuO9s+Lf1Q0EL5gdu
         UC7lJucEsu1nW+XDyif8zWVYjuHdqUZpLzwvxBDXj1RKTSrq+9PMokC62KgeJb+03+6S
         1ib1uFHObmJ37zQC2cN17TMkUKa7gj7/FL4wqWkS3r+YRB4Zlp7c6V9OLDwYUgiXguOe
         8mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzsECpQQZWszrfGpCKzDzrw8iWPksBCj12PLooJzSsE=;
        b=4cb8b3SZr4+jisqtpmfZG/dlzV0hfVzip46+UWPPDNysSXgTrL6zQ7U5z0d7wVgXty
         zOOXoSPgFbP5k3cDiL4TzAwZKT+dS5useRK8xcK27DZKi5/snVvIlpLE1cyYME8tiN1A
         TnW8j9oKOgPIBC7SxQEK904ubt36hHdz/CSZJWXKjXYMIADGYDYggn+ZRF4rnfSxcMbO
         I4BBCZocbk5Jrlnpn6CKDGvR9srXTioQiRGJp8fAWSOjDs8tjsTp0hyiX+2XZmFXvSy6
         JPwppUKkn3DpCWAveTlJ51ci9KYQ0DXrXT0SBoIuozBezbmiaIedBVaDHMwf/CjJp3+x
         3SSQ==
X-Gm-Message-State: ANoB5pmLrayK/8qgMihMM/lS6lBhlbwKHVHBevuDYb7jkJdl5XlCplTm
        Afq+8hlQ7kxsz5lWb4itpsi6I3Hwkb8IMUILZBY=
X-Google-Smtp-Source: AA0mqf5zDm5eqkwLkhcOXy7AK24DfWzHKDrGW6/Cm6gomNfWv3DywyCyihzdJ0G9JlQCz57xOOa+uVqV0e/B09EM4jg=
X-Received: by 2002:a81:4e58:0:b0:3b7:a71f:66c9 with SMTP id
 c85-20020a814e58000000b003b7a71f66c9mr31907694ywb.295.1669881066301; Wed, 30
 Nov 2022 23:51:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:29a9:b0:315:e575:23ac with HTTP; Wed, 30 Nov 2022
 23:51:05 -0800 (PST)
Reply-To: garryfoundation2022@gmail.com
From:   Garry Myles <maryammuhd017@gmail.com>
Date:   Thu, 1 Dec 2022 10:51:05 +0300
Message-ID: <CAN+wjN-QzWZA5+b1gYe7T-2F5AWS6NjF+oeZ9oB3Hru+PR5gzg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [maryammuhd017[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [maryammuhd017[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [garryfoundation2022[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--=20
Sch=C3=B6nen Tag
Sie haben eine Spende von 2.000.000,00 =E2=82=AC von der Garry Charity Foun=
dation.
Bitte kontaktieren Sie uns =C3=BCber: garryfoundation2022@gmail.com, um
weitere Informationen zur Forderung dieser Spende zu erhalten.

Dein
Garry Myles
