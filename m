Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AB44B3C84
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Feb 2022 18:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiBMR06 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 13 Feb 2022 12:26:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiBMR05 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 13 Feb 2022 12:26:57 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BB72F7
        for <linux-ext4@vger.kernel.org>; Sun, 13 Feb 2022 09:26:52 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id j2so39877046ybu.0
        for <linux-ext4@vger.kernel.org>; Sun, 13 Feb 2022 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=JNBevpQydkd5xopZfGev9uP4QgWzls3vxLU2e4Aw0PYoEe1CuegA44GnQJMWZ6seYh
         kYPPyVqs9bnczR8G8pNTR3FiP+PsNT7SNrHsffl6NxncUN2C1rkFWR3VdgRN0VntONk2
         JyIH/2wLypMwGKiPg3iyp5qiIDIcG5WYt8dv91Cy8pcv64PZMqPhHovMokivQs9uxrAF
         /3/TbsN+ewlXWGIhQ9wUiyMpnv2ADEKSB4lF8AF1EufamCWl97xsKSgU3TrRWv5mUuGv
         U72Aidu5zkRFlUsT35ChWbxDBwysETnB1ghHGOMWxM57pX8qYerxolnu6F9FwgmazEdY
         80DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=donUCm1pMiuXj16KiRiXR/kd+ru16GIVsnL3CjSgGuZWJuSjwCZ/E/uLHVlaWHVoqp
         2OTnMXKInCXf8M+s5KZhe5orrW86gbIoimFRdz1JVB1sJ9y9aHw6f2zBluiPUOz2py5F
         RGFTqtQWhxWwhid3E/rvP+cmhN0qYFtGJpT/MttlUjjnGXN1WaKGn5JtMDbCMdELTSaR
         HebHNz7rRqz83AczEOEv/lYOXvlFvg2a8pcL++TPh1Fn4PBXY3JBQZjqWw6UwVvLGh1X
         KEm8aVMj+mhDkJdzqrKmS5mhbaNkBOhqmklugvNijoNsh2ZMm5kNfAmiRtaTIGHqAcuH
         33VA==
X-Gm-Message-State: AOAM533qBm8Jfo+yzfuN3jd0esuUJ/jFWXBTiukhMhqbsaj8146KvENe
        jejqtUHendM9n80RP6PAAKUVZAf4GVrpvGxwRZU=
X-Google-Smtp-Source: ABdhPJxp8iX6UBO2DGBXQ7+6vw6gbw4lMEeQ1qsg2e0cqZ4zAZ3TfWsWue5vMgS0VNdpjEbCTpRZ5L/yNYcpP3/PP9s=
X-Received: by 2002:a81:3442:: with SMTP id b63mr10677907ywa.493.1644773211251;
 Sun, 13 Feb 2022 09:26:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7011:812:b0:1ff:f81d:242a with HTTP; Sun, 13 Feb 2022
 09:26:50 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <gracebanneth@gmail.com>
Date:   Sun, 13 Feb 2022 09:26:50 -0800
Message-ID: <CABo=7A3X01qQaaiHxRZLK5aGBiFMhb0SngWX2gHtG8wXqVtutQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2b listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0643]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gracebanneth[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
