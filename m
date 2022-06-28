Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD85C55E9E1
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jun 2022 18:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbiF1Qf3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jun 2022 12:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiF1Qem (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Jun 2022 12:34:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DD330F6D
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jun 2022 09:31:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f39so23284166lfv.3
        for <linux-ext4@vger.kernel.org>; Tue, 28 Jun 2022 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plu-edu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7yiGZ94Gh4vRl9mZUVCwfYEf1dp4ree/KLDLMgwW5e8=;
        b=q4WUKmSN1K3msOOGWXD4F7VnoEfCtAXOYiWB7uUUOWvLwXqp2BoBhZ6HfnUJ0M8e8X
         M/3Podr9jBAOF8p3qektPAABhsWtekc9SPvZt5RPQBJ/P5Vz52NagikkQgUgXsGD5e6d
         HsfJ29xQCn0H0jebIJ3dfS1Gvg/1WX8+peQpL0JYGOk1WIjovRN1ZQA8Ph2ok0Ue/zat
         VRbO8pwv4044wjDuQEuIbzGb/rQgRDSHw+vvxgtl2r+TJTdfO21Hue3fCJmvE4LKGq3Q
         oD0yJZpI1+cho3GJI2N+jmY/kg8DH5jA4lCBnxsTr6xrnQZd1Nu0mq1RGMYsZ2/6fGQx
         zdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=7yiGZ94Gh4vRl9mZUVCwfYEf1dp4ree/KLDLMgwW5e8=;
        b=oMiYIn7M5EmL3VOPpTCbMBYmkKGrkff9Ao0npIEhKjc8DoPrWwwgto++Kh80AWfCu3
         AUin/v9V4nL2rMDRiC1co9++ABQsY7IVDQSOHaTRufFZWsH56M+lNAHcTbREir9I+WrQ
         5+DdTUjLxifkkuQxMtMFwM9yQMx4/GtNCdPLKDpl0lSBNvgXqVh3wnLB9HTIQvpclTti
         sDlogEZvnZjqBrp7jBc3qm/S3Vxi9KF77Zt9hCUHxXCmyovJ8Pl8nuehTMlSjAwB3vSX
         HwkFigyr+LSViP4cZhmYsrR71Autw0mfZM81GR1dLfq9rSgHChwlUu5bWE4NsOgR4UUi
         Bq5g==
X-Gm-Message-State: AJIora+3USXsxx3PDkBiSem+ww7omkvEugftCwHXU8B0lro6unnlCJxQ
        79xqOywknDwyYK8kS0ksNaOuMAoek2bgo6RwYpgNyw==
X-Google-Smtp-Source: AGRyM1vRgT0WhOmcBjUo5VRXFHoUgbh/NlGCXDWSo4cqOIxSpGttKQK4/4t+Qh/ZGKfRU6ezyLxtVQtsP7Sj5SBaFAY=
X-Received: by 2002:a05:6512:102a:b0:47f:a442:7178 with SMTP id
 r10-20020a056512102a00b0047fa4427178mr13139730lfr.30.1656433898938; Tue, 28
 Jun 2022 09:31:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:da8c:0:b0:1f5:486:75c3 with HTTP; Tue, 28 Jun 2022
 09:31:38 -0700 (PDT)
Reply-To: crypto.investorstrading@gmail.com
From:   SIEGL RONNY <lindnelg@plu.edu>
Date:   Tue, 28 Jun 2022 17:31:38 +0100
Message-ID: <CAJeMfn+qF8E975HC6Dc6vmVTR954j9DQwdNLb355eGW_AXVKkw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:135 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--=20
Hallo,

Verdienen Sie w=C3=B6chentlich 65.000 bis 130.000 US-Dollar im
Bitcoin-Investitionshandel. Es ist sehr lukrativ, dass Sie
m=C3=B6glicherweise keine Arbeit verrichten m=C3=BCssen, nur falls Sie eine=
n
9-5-Job haben, wird dies Ihre Arbeit nicht beeintr=C3=A4chtigen. FRAG MICH
WIE? Kontaktieren Sie uns f=C3=BCr ein direktes Gespr=C3=A4ch =C3=BCber Wha=
tsApp: +1
(201) 590=E2=80=914385
