Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32D9522B50
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 06:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiEKEkh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 00:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbiEKEjs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 00:39:48 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4FE153513
        for <linux-ext4@vger.kernel.org>; Tue, 10 May 2022 21:39:24 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so1460816fac.9
        for <linux-ext4@vger.kernel.org>; Tue, 10 May 2022 21:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=s3Cdswvtyrq8qHVwuRB9YRoTAIoD9G/2//h6WeFZHzo=;
        b=nrkBIDyCffFbQz5WNhQU88q5l+bx8m1CoLNL/nRcxBFZRgp3B2RwRJzpJi69hjmFPQ
         Eotn36CVTQor8sTwq84btYhQQ+OsypTpYdHIfGkC/Ekjg8a9U0HkQq0T/gbcQg5/if4Y
         i1yzcJYhTRMm8ny1NIiOYUNRazrfloxlCC/1XVxW2+TG0ItQpx2/G3cXjgMuOALgO1Rc
         auxKHXwS3ghK6vFFIfR8essc70JXfRi2oIpi3YT/VLqISCMTaVWCOI/Xf0rWfpfTmlnw
         XgqCFC8jOuHD5AjsEtox3h0b9tzcHlVM0fA1RrJyDFubK9aS707t1BYf/K43qSc4slo4
         wrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s3Cdswvtyrq8qHVwuRB9YRoTAIoD9G/2//h6WeFZHzo=;
        b=V1z6mCbJvM8rH0/bwtfLGbpS61FDRkguYSEuEaaxLejgaH5LKqQBt21CHUXXQjVOoT
         uUhmYPHU7f6J6Ysxw1J67RrqzLhXSCBmKr6SU6o9pp9pbgFKlXpRT1fYOgFTYBKjrUhk
         LPrnOto5qfChsIOfDLWW6FIXjavIE3GenyCU406IIk52flYvKb038osUGv4EbcUUkimD
         6bBygq+fJ71fzE70IEEZER3VgQs1GZXxBzhTGun8d+jvXi9BSDKUDbPskLNa6LxHPMWV
         ANEu56+hzVSk+91RXoUIYpl6qjA5OwS82CRp1VCQLLat+AX3DoJoreYLnzkxQjO7iIGd
         7PMA==
X-Gm-Message-State: AOAM530Elc/BIHGnYl7/APzMlCHHKDxmi3u1EYFYPJTuWfg1Knn/tQDc
        hHBN2aPGCUKK4aPn0ZpGMGJrU5gCSz+A4/OJ3FWoB6I8QJm/Ig==
X-Google-Smtp-Source: ABdhPJwbKHmbnZDflMHBZCcp2YbZAAZvFdPcM4owWeuPIkoxodmwIZJ+Xpgi08ylB1RFXLrw63SQRxJzumbwJKMTxhs=
X-Received: by 2002:a17:90b:1007:b0:1dc:9862:68af with SMTP id
 gm7-20020a17090b100700b001dc986268afmr3261389pjb.205.1652243951499; Tue, 10
 May 2022 21:39:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:319:0:0:0:0 with HTTP; Tue, 10 May 2022 21:39:10
 -0700 (PDT)
From:   Private Mail <privatemail1961@gmail.com>
Date:   Tue, 10 May 2022 21:39:10 -0700
Message-ID: <CANjAOAiiVcSrSv31FjThCVmeppS54UVvGVj3SRSvMfxOB+T8DA@mail.gmail.com>
Subject: Have you had this? It is for your Benefit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DEAR_BENEFICIARY,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Our Ref: BG/WA0151/2022

Dear Beneficiary

Subject: An Estate of US$15.8 Million

Blount and Griffin Genealogical Investigators specializes in probate
research to locate missing heirs and beneficiaries to estates in the
United Kingdom and Europe.

We can also help you find wills, obtain copies of certificates, help
you to administer an estate, as well as calculating how an estate,
intestacy or trust should be distributed.

You may be entitled to a large pay out for an inheritance in Europe
worth US$15.8 million. We have discovered an estate belonging to the
late Depositor has remained unclaimed since he died in 2011 and we
have strong reasons to believe you are the closest living relative to
the deceased we can find.

You may unknowingly be the heir of this person who died without
leaving a will (intestate). We will conduct a probate research to
prove your entitlement, and can submit a claim on your behalf all at
no risk to yourselves.

Our service fee of 10% will be paid to us after you have received the estate.

The estate transfer process should take just a matter of days as we
have the mechanism and expertise to get this done very quickly. This
message may come to you as a shock, however we hope to work with you
to transfer the estate to you as quickly as possible.

Feel free to email our senior case worker Mr. Malcolm Casey on email:
malcolmcasey68@yahoo.com for further discussions.

With warm regards,

Mr. Blount W. Gort, CEO.
Blount and Griffin Associates Inc
