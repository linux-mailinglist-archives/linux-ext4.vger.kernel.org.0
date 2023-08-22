Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7B2784E5E
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Aug 2023 03:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjHWBpN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Aug 2023 21:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjHWBpL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Aug 2023 21:45:11 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 18:45:05 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A4CE58
        for <linux-ext4@vger.kernel.org>; Tue, 22 Aug 2023 18:45:04 -0700 (PDT)
X-AuditID: cb7c291e-055ff70000002aeb-8e-64e54c31b02c
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id BA.9C.10987.13C45E46; Wed, 23 Aug 2023 05:00:50 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=TiurEZiV8ev6drmp/YWKCA9zDioJISL3y/il1yTChWTtOmTgR3f0ICFtTeMX/v5EP
          roVxvS3487oyjHY4YCY0q2k7mtnWpmUuPbcxO53epXR6k6JdAV/h0aUfMZtxsfGmF
          W9Noq4MD2c/2G9HFTZc6QQvq3J26CBSI6xFzgazE8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=acFXcIJCCgRKi9QgOBDUilDFvjB01OhmIviKT5YYdyeQlITAeqBYmQFA61RZCOhLO
          yJvmuujVcn2mwwvzXly5N7EgafjM0SyabFzMnN0caQeS7Z/1QmXjY/+/nwopfcMmD
          vIxyt60GXwC8vlvE6qjk4KK/e3q0+W3C0ENInb8b8=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:00 +0500
Message-ID: <BA.9C.10987.13C45E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-ext4@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:14 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVyyUKGW9fI52mKwT91i5nz7rA5MHp83iQX
        wBjFZZOSmpNZllqkb5fAlbFk3QWWgt3MFW39i1gaGB8zdTFyckgImEi8fL+cvYuRi0NIYA+T
        RM+y82wgCRaB1cwSM2YZgCRYBB4yS3Qsf8MKUdXMKDF7+2pGkCpeAWuJC5NmsIDYzAJ6Ejem
        TmGDiAtKnJz5BCquLbFs4WvmLkYOIFtN4mtXCUhYWEBM4tO0ZewgtoiAnMSrO2vBWtkE9CVW
        fG1mhDhCVWLdhptgtpCAlMTGK+vZJjDyz0KybRaSbbOQbJuFsG0BI8sqRoniytxEYKAlm+gl
        5+cWJ5YU6+WllugVZG9iBAbh6RpNuR2MSy8lHmIU4GBU4uH9ue5JihBrYhlQ1yFGCQ5mJRFe
        6e8PU4R4UxIrq1KL8uOLSnNSiw8xSnOwKInz2go9SxYSSE8sSc1OTS1ILYLJMnFwSjUw1m5R
        apquu5PpD8elmWnbag/c+M1pr1O1N7fj2zkR6Stf1W6e+300mIW70sMuL/pSx8qLb75O2hOv
        Zfur5lSli6Ms551v3hpiu2KF13OvXpr6bc2Xx+wTMjMcZOdIbfuxQbJBqPSS0s3dPCcM+jne
        FDRL6bEzlnfU87xaumrnER0xUZsoff1+JZbijERDLeai4kQA37EG+D4CAAA=
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

