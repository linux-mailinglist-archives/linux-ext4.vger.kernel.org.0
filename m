Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B70662DC4F
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Nov 2022 14:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiKQNKP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Nov 2022 08:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKQNKP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Nov 2022 08:10:15 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DC16207F
        for <linux-ext4@vger.kernel.org>; Thu, 17 Nov 2022 05:10:14 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id h132so1800482oif.2
        for <linux-ext4@vger.kernel.org>; Thu, 17 Nov 2022 05:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LOR6tOZrp0D2QD5xmqX9poJB4IkjPChFJp0U/61A1IM=;
        b=V6ctnxN3M7Iarjkb1mBa8MfhcBaDRpuTIHvjQqJBJdNb8GsoZdcj342BuO1lsgVirF
         ZGjjcwuE7+eCKoKQeB4XxrYKZI55bIfD3Qf0qi6CVpkp2IBcdZTF2ntfYkNLp0/Kl+nb
         TYc1bKjHdpOaJLlpTLiNKSave0gvmT0uY7uqmZd3HMD71kTVZjFO1vq19gSDYHIcJs+F
         UMjO0ujj+gjd1g9EXff5+rtPIOESXQoAYBEdMv4wEkNftU271FKxD68gRqgU4XJmGeWx
         1a22REgCoUrwJhfmxmWav+svIRn0gnO5X1zFkHsoSDPyUvzzXZJ6oY3fGgAOS3kKrX37
         64gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LOR6tOZrp0D2QD5xmqX9poJB4IkjPChFJp0U/61A1IM=;
        b=lwQRiNkIRBbFSXBUgrjvwywnbo7+u3RZaRckZ222KIvFMWrtxgLh7MdyHqJwhSTDcl
         R4AtC01kYGK2UE3xEHtP3p0zRq1egWFNxrp6/i5jkw+539i0c4yhRtJwbmVDpc3gGde2
         Ao8cidvimxNXjBa7J98eTAtS72rEtG+hFgMmEBPDzKRVeLuPlcZ+SUqfw9z6w1KgwqA8
         t8JjQnUMKn9fPBfKm3LvyYfBUQQKPTbs1Z+pXUFkJfU6j4HDVkVfrTgmzy3Y8zkfQX54
         Fq5i11uQAUY9xOYQXxW1mRdpLaDeTLL70aPN1B6ZoCEVm6ILRvdwxoV6DcXH+hxCMDOw
         06rA==
X-Gm-Message-State: ANoB5pk5t+Ry1FDOnJq/WhUVjaQSZTBFEUE3ZR/Od/+wfg+LGoT/wu8X
        WmJ3YleMb4p1FF8XZz821iS6tpqxiD7AmHKfgXs=
X-Google-Smtp-Source: AA0mqf4khaw+bzdj+bPD2C8vqqYbg8AjiVknCN7pwixN9d2XtVrNC2jqPMfofD8BevOb80wc006MOF0kH3NiX0IEke0=
X-Received: by 2002:a05:6808:2211:b0:354:2c52:51eb with SMTP id
 bd17-20020a056808221100b003542c5251ebmr3771001oib.89.1668690613739; Thu, 17
 Nov 2022 05:10:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:3801:b0:dd:706e:8c93 with HTTP; Thu, 17 Nov 2022
 05:10:11 -0800 (PST)
From:   ryan johnson <bosranjo670@gmail.com>
Date:   Thu, 17 Nov 2022 05:10:11 -0800
Message-ID: <CAL-LBhBo9AooKRbmq3oCxUW2uJUZgKtvzQGu8xwe2PihfqFdFg@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:244 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5459]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bosranjo670[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bosranjo670[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Good day

I am Mr. Ryan , I am contacting you based on an investment project of
US$58.7M , so I will be happy to know if you will co operate with me
for the success of this important project.

If you are ready and willing , kindly inform me so that I will give
you further details about this.

You should reply to me through this email    mr.alfanuru01@gmail.com

thanks and waiting to hear from you soon.

Ryan
