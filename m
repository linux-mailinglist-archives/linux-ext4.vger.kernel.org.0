Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921806FB68C
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 20:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjEHS7q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 14:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHS7n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 14:59:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB176187
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 11:59:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso9290819a12.3
        for <linux-ext4@vger.kernel.org>; Mon, 08 May 2023 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683572381; x=1686164381;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=QT9AWBIhqIiz2a7K5QwZfbofQtx8oLPUIWG8QwW3Wvscr7Wr/J0Hji+UlJct3X0zhN
         OyeHQSHnq6x2NMFgTCREDvkOiITKqOqez1EZznzKqjgrdOtj48IxwRhCSeEl8jIFomyt
         Js7YGbXjXou1TKqL+/op1HIMmi/I9XoEXyDtTxwa2aoiLo1vC0KCXC6NP2YKfSAW1Rth
         qogYsABisEMsKjqoP/fCjzV8afwM/8jiWI9yZUK9tukS0oLLW5PIij6+o5h0VPpJSCvx
         QJ7mU0MPnJajEkI2bupuKohtl6MMDIRDlI4bkzH0sw93TIwLoTwrVmR/ckdCSBxcA3V/
         sIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683572381; x=1686164381;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=VRHb9JLxiIrmvWCQxN42VBIfgGTkj5JdqUYTVr0zw2Lntzi5lg56DEVdGWMAVRYOkZ
         Vk0JGnnqSQpiOTgFw9JjiHgP4JMT4CKEBOCLF7soEtZQl9DHd3wbj40qAgZUy4ebwRDk
         HTLtn3494T1lfa5ywPo2jCMo8MJAyYHRHMm3sAU8rdaQyS9t1xAEqgguxNxR16Nt2DoH
         91m3PIprLXigKGalEFyGQhP7d8jIAhOMzBggu3GNoT4xheritY/d+cSXwdpXkRUu7VDT
         TadH2Nvn+qwXN6PZhvNHpdMVp0k0hWUoGSuPzKohrpJjxp4AhTfK4Ge0g1FuWPjiqyvD
         cuzA==
X-Gm-Message-State: AC+VfDxMG9wqOeQTttKVqelRYHt7GwL4LhL3ioCfeRoQTqV9ldO1uQ7v
        GtaJuGem8vjEE6Fl7aOkW4zgrbfWiT8ps3SP6Q==
X-Google-Smtp-Source: ACHHUZ5ZooY1O9K7OXKpFhxHX0U1aBN+ebrzdCe2QVsD2zyiFWljBEAf9T4bOQ0P8I/769+nonflrGtTdy5COP5frfA=
X-Received: by 2002:a17:907:360d:b0:94a:7979:41f5 with SMTP id
 bk13-20020a170907360d00b0094a797941f5mr8296447ejc.71.1683572381032; Mon, 08
 May 2023 11:59:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:9343:b0:906:449c:e24 with HTTP; Mon, 8 May 2023
 11:59:39 -0700 (PDT)
Reply-To: pmichae7707@gmail.com
From:   paul michael <pm9568521@gmail.com>
Date:   Mon, 8 May 2023 19:59:39 +0100
Message-ID: <CACSDF=96xTTW0X_tPhfbOXJWOEiXOWPzGBXeeMzir=XLeiDi5A@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Every time I retest your email, it tells me to check with my ISP or
Log onto incoming mail server (POP3): Your e-mail server rejected .
Kindly verify if your email is still valid for us to talk.
