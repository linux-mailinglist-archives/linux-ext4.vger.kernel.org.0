Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8481E549C1C
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jun 2022 20:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbiFMSsX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jun 2022 14:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345035AbiFMSsE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jun 2022 14:48:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9946B2252E
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jun 2022 08:08:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s6so9294920lfo.13
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jun 2022 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=nQfnDsNAwBhiTzvcCVWAW+CtmC1+ndx2xo4KA92H/eA=;
        b=MlwlmNmKHNzD13seN94UW+/7T0WzBdL96B/0FqnrA1P7ZQ+9qIKaDsODi9Voc9VQCE
         GlMZ9tb9S7LlvCdOx1ct7lzBW+6oGv14ca06gD2IEkCQY4/Iu0PNZRCyZumF1efhvjy0
         gJg2ai+A1zf2NkflqptwDYNJxgv9/ZOzR8mOmNdSMB8xyvRRYR2ClLSnGNG1eP9XZcqc
         G71CZR0oTM2eZjbsNpjMNHyqsTm58N6VQ/AW6IWkpxchvGT6T+skkuTZ6KTnRojIdr18
         2uv9qrdKBW+IcdPGzpH6qcyzaht11Ud0BKnJa17ToTQ+JsqPNwUujFREAH/YmKa+lA+m
         nlig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=nQfnDsNAwBhiTzvcCVWAW+CtmC1+ndx2xo4KA92H/eA=;
        b=wYpVpZGCaVQEAbYSD0nwO5vGJuD+EoWzCn0yfLNWiSWHwKFyDtCPvz9C3CDKX4lyhC
         EeHG/dN9h8VqoK6DOnFUwuZ8qrXTNeh+dhr7Bl/WV5xH/CHu+kngBGd1PNlQmjDoG+dz
         R3EeBlMfxCzsKLEhioJ3S9dPC4vN+C4CGyjg7unUUeqFriD9f0OvQYwWUKjvYIR/L2BW
         +mUPfDZAkQROwEx5vClShFC09v8FVnYvfoQUhESA7s0aA6TzwjZCSXYvUwYbXAbic4pj
         QnJ1e1nJoVDht5DnAH+yx9BRa+k7JnFs9mDEvLTJ1dKnWTHO7UWUDcexfe7XqysAZp1E
         hdnw==
X-Gm-Message-State: AJIora9iNr1AbTf9RZF9rQe2oY5E8bot/2yTktSu1//iLPZwr+6hveLt
        QdIJzfh9QydG1t0HuZGQFvFHI0sms3B83GimTew=
X-Google-Smtp-Source: AGRyM1v9bRISRBXfbvA8nAIABy5S9g6DWP0Z25yym1LZQlsQYv26JGJi8hVNBR/xgkH1K+/WaAAQoJU629IzhPAr5zo=
X-Received: by 2002:a05:6512:3c82:b0:479:4df2:c58 with SMTP id
 h2-20020a0565123c8200b004794df20c58mr199905lfv.276.1655132883574; Mon, 13 Jun
 2022 08:08:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:c043:0:b0:1f2:9bf5:c464 with HTTP; Mon, 13 Jun 2022
 08:08:02 -0700 (PDT)
Reply-To: nelsonbile450@gmail.com
From:   Nelson Bile <chibitovictor@gmail.com>
Date:   Mon, 13 Jun 2022 17:08:02 +0200
Message-ID: <CABi+MwmDw_PrnBKoNCDtvfe76Ex_whfJacr2iKvfehjLnmBxgA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5018]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [chibitovictor[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [nelsonbile450[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Greetings I sent you an email a few days ago. Did you receive my
message? urgent response please
