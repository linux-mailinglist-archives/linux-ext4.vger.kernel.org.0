Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED23962107F
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 13:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiKHMZ6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 07:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiKHMZz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 07:25:55 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADDF4FFB6
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 04:25:53 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id h10so10089212qvq.7
        for <linux-ext4@vger.kernel.org>; Tue, 08 Nov 2022 04:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=jCYo8RYwbrzkYOVj5WJhufPxwk0UsnU4PISt7mt4ZNohQ9iZwPaaAhSViexeI0Z+dP
         S2YVDLAfG6OY7EinrHw2tgpAjGr/Cwwwkmmi39vBEkd++H4pWVZylBAgV5XMo0T+mep/
         iyXisD4zrZT7Y6nFutY95kKPXlip4yzo2fxRTVzTWCBCMD+2ZH6og7L3TeBoF8RoHQg3
         MHdfkTAkCYdUbdD6IIuN2GZCYkKcgzZpoGkiBjrjoYA+tghpmm8mBGjfH7YeVZO/fFTV
         shL0M562/AGZT5C8bUJ7b0pNxUX9GJGIVb8Swo+bJo6/N9JyznkDfZqNJ84203qGMdlk
         EGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=xBEUDnX9/PCVCnpS0NhROh4ncXoHegA2+4K1yEOw1+VXId8+PA3yNAPUmFENgpayPW
         6TO46251Dgxcd7drVUiRjf94dPTDNbSQvnNVN0lXOVcIhH1UC0i4AnYcqyO7pKZaN1ug
         N+1XtHK8TwCbfUtVoVMZ3tPxRx+2M+d/UAC4eGoj75WdEZUz4xIeGnMAojuVnHKQj/I8
         H1G8s6mKpKUwHN+WpvhRE7+Z+0UIkZdhUnRbnuTuImtuEX9LNUIJDX/aoGMoakp7pcEL
         4oInd6nOMOVX4WXWp/TauYcchGGC1WY/u1Whbr5rCbXzTP15+n8MfWR/Ao6w9AHDe2yc
         jUjQ==
X-Gm-Message-State: ACrzQf0oNH+dWFoWxg8oNx/F7SxJRBrlKCcQBJxdZDkoGD86SW5U5dbU
        U7QK6YAJuFC0Nk1v4RRWYGMaiiaMHuHnOOQdwf4=
X-Google-Smtp-Source: AMsMyM4enNp/AjKT4tfs0jEImNeET3uerfTgVTfte8XjbOEn2WA2ZRt9BjEVgvhE/yDkDoQCRS1cgyqvGVC029Z6UTg=
X-Received: by 2002:a05:6214:c41:b0:4bb:92b0:3873 with SMTP id
 r1-20020a0562140c4100b004bb92b03873mr50115550qvj.76.1667910352645; Tue, 08
 Nov 2022 04:25:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:2f8a:b0:4bb:6e86:8303 with HTTP; Tue, 8 Nov 2022
 04:25:52 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   Mr Abraham <mr.abraham2021@gmail.com>
Date:   Tue, 8 Nov 2022 12:25:52 +0000
Message-ID: <CAJ2UK+YrtzYn9_zOXMtnYaO0eGg4gorFMzUobrJ_z5o18RFL7Q@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mr.abraham2021[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mr.abraham2021[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
