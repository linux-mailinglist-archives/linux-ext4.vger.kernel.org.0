Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C32559424
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jun 2022 09:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiFXH0N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jun 2022 03:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiFXH0M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jun 2022 03:26:12 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B384D612
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jun 2022 00:26:12 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p128so1892958iof.1
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jun 2022 00:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vSSEkyPj+FsS/ZQkIahniv/onkImUXOiON1RbH/jEZ8=;
        b=Mys+nWzqH006jLfPqnK6F4/L0p44xTmroDHxzdbcoGVbu3YK4H6hAERzibLck7HINS
         GvSyPek2n7Oxh5FRs4fA26pBvjasXG/f90m19l5BBpBd5xSbuHz8b398/PVme1DLHch2
         lAzJ/J0QOPcxFJwyL4bSqrn9wu9GX/M6UI3c+XSkGSupHTbTy8CftBrc1szJn3v8JiLQ
         AmxcmI65g4s8CcVORzBLiByeKPj+ciRtI6s8r/oRNxPsLmGOyUNLCMRBbkR9DHcvO/wW
         YFvhSpvjXNw2m/k37WLewbkzdg/oov3PzmXQfjRf4sWRoCMrVuqZV4zDqntmgn4NNrVG
         Ij1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=vSSEkyPj+FsS/ZQkIahniv/onkImUXOiON1RbH/jEZ8=;
        b=uJZt/qYlVO8Zj8Rq5LtcrhEphQqVCmxY/MpqQtCrDByOJKHY+CP83OchUp7V/ryiJV
         d+YzMtcLTAnczlD9JXqtW+7izmqdugsRBqlvGSP7XdWCF3leDk2d3STthtlfHIaF8bry
         /p3YIwkitIev+P9SA1ddRnwpLtWmajenxejLYOyspXItbDipslI1TbWgUFhgGch+2NI8
         GB07+MoxLW421BS+vR0MoKgT/6DEUG9kpXPI62tt45uhlCCXlqq/jgAanxhUIByV/xuT
         Tm0AxfbFxlId4Q47ZuIeK6kYMHx/SSf95faT7DMhLrP5cSqnQuhMet7DLBo3p+fWiovr
         ZvLA==
X-Gm-Message-State: AJIora9CJ8vjPTx1whk/4M9NLcKk10kWFUqp3BCoMFRDmtARH7X39i27
        TgBOvH+OomI6fpvfHtN15viOxVIl29K2T8jV6wU=
X-Google-Smtp-Source: AGRyM1uE11HmqH0QCTWtYGp0RbTP6bhTTAKRS5MWYPkJZ814K7THs7Yt3NLjjTmN7egavwhcsb8mXh8OqolGnoy9PMQ=
X-Received: by 2002:a02:c64f:0:b0:339:eb0c:87ef with SMTP id
 k15-20020a02c64f000000b00339eb0c87efmr4103569jan.28.1656055571406; Fri, 24
 Jun 2022 00:26:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1a06:0:0:0:0 with HTTP; Fri, 24 Jun 2022 00:26:10
 -0700 (PDT)
Reply-To: garry_myles@aol.com
From:   Garry Myles <mavisfoundations@gmail.com>
Date:   Fri, 24 Jun 2022 10:26:10 +0300
Message-ID: <CAAoguPVYirkz59KcJ=_v4SOieC_YF-PrvHXzaXUV1Z70Dkvc4g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--=20
Hallo, lieber Beg=C3=BCnstigte
Sie haben eine Spende von 2.000.000,00 =E2=82=AC von der Garry Charity Foun=
dation.
Bitte kontaktieren Sie uns =C3=BCber: garry_myles@aol.com, um weitere
Informationen zur Behauptung dieser Spende zu erhalten.

Dein

Garry Myles
