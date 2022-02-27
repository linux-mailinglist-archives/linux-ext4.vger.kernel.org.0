Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3164C59F1
	for <lists+linux-ext4@lfdr.de>; Sun, 27 Feb 2022 08:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiB0Hyq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Feb 2022 02:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiB0Hyp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 27 Feb 2022 02:54:45 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1631EAF2
        for <linux-ext4@vger.kernel.org>; Sat, 26 Feb 2022 23:54:09 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id p14so18889485ejf.11
        for <linux-ext4@vger.kernel.org>; Sat, 26 Feb 2022 23:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=QU+cbZmU18+dqFnGocwGCLSMZiezXCdYalW0v8ApfXA=;
        b=UldCrSy5q+8gA+zzfsoNSTqX3VeNJsj6O0hVmWdQklZbedq/MpDa5p+g/Q88L+MvOI
         RAdp5qxZ67Xt9JKmb29KDhMYp/tasVXY13POBUK94UUbCTeMVk5WrJrj3yShYUr1owei
         PIzbtNYm9yFKymd9Vb9x1PCyYYaCAew1ztS0frzXfIyNID3REXikshiyTiOK55z91mqC
         2RsOmJ27vprGjrH86hsVQNQ/GdCCUDHgMV6efn8Io+07ZWhDBCYP9BX/JP8lfyrP/k0q
         V0/VO05QuJM1J8erSNih4hbCS5Yfo/S0MRg1mRTdqyn4opSLSI8guLAWS8dQXOFa/Ga6
         pFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=QU+cbZmU18+dqFnGocwGCLSMZiezXCdYalW0v8ApfXA=;
        b=Lm1QQ9NI5ifNf15ZJGxD+MPdPRFj72ULAm79uZ9I93EsTO1rAFwXTEe+0d8ue32RdT
         SG9IrIHb7X6NQQZ8kU+cI4AJI1LRtLr0TO4cKIu7A8hH/9+lK6L7XL7WB0XAbbRLrUQT
         yiLdFTySVqRCg+ufrmB90LFJUmflfBHZ5wV7DTre+KOGLhW6GcNRzKRsGBDw9LN+OSGZ
         SpOAUxBRsZF793Lln9oLGw5/ems89Bx1fjTBlQZGJRLIvNGES3lo2kl3++tWsUOyxBzl
         hTlR8xJC7S2NGXBGadOSUQk89AFkExnU9F8XbG3uVO0aHcxQzsChDYJ5I2iNVtKMrCP/
         FLrw==
X-Gm-Message-State: AOAM531fiAWLv7gSzRXEn1pBXXzhUw+sVmQ72oCeHhj8ghSztN1JC9s/
        IKrFOkvKTphqxQtG+QdgLVu5bSnO8be1t8+gGBk=
X-Google-Smtp-Source: ABdhPJwHsL4tRezpw0DszG32bGAmOrRH2c8KIVL3E1AuIzDUS/4uZyjlHJ795uaKkIwQdXeLK3f00MQr1IsPFj9q/eQ=
X-Received: by 2002:a17:906:3941:b0:6d0:ee09:6b67 with SMTP id
 g1-20020a170906394100b006d0ee096b67mr11485674eje.45.1645948447379; Sat, 26
 Feb 2022 23:54:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab4:9906:0:0:0:0:0 with HTTP; Sat, 26 Feb 2022 23:54:06
 -0800 (PST)
Reply-To: hari_kunda1@hotmail.fr
From:   Mr hary kunda <khanadbul01@gmail.com>
Date:   Sat, 26 Feb 2022 23:54:06 -0800
Message-ID: <CALr78wVw5yzxVFCib093sT4_zBCp5tR70AR7gm05Ef+JSM19jQ@mail.gmail.com>
Subject: Greetings from Mr.Hary Kunda
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        FROM_FMBLA_NEWDOM,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:642 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0006]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [khanadbul01[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hari_kunda1[at]hotmail.fr]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [khanadbul01[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  1.5 FROM_FMBLA_NEWDOM From domain was registered in last 7 days
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

-- 
Greetings from Mr.Hary Kunda

How are you and your family?
There is a business deal I would like to introduce to you. There is no
risk involved.
The deal is worth $10.5 million. We split it in half - 50% each.
Revert to me asap if you are interested.
Regards,

Mr. Hary Kunda
