Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C2E64BAF7
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Dec 2022 18:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiLMR2w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Dec 2022 12:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiLMR2u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Dec 2022 12:28:50 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6D51F2C8
        for <linux-ext4@vger.kernel.org>; Tue, 13 Dec 2022 09:28:50 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id z26so6058602lfu.8
        for <linux-ext4@vger.kernel.org>; Tue, 13 Dec 2022 09:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=DzMldxNR8LNNVMx7vuJnOcLw6NLucC7yEgDxlRn6PKyaO4h/jzW7TZzJYxz3D7DW17
         FT6AkRuDEerBkse+LCZOqO7XVWjasYCMnl39pI4H3N+1/v+r/rD3ggJ8XgtQCwPi6YRP
         KOZUKNVnSEN1FicY/aK40Y2RXNiWJ1tYbH8htcAQKlzZzWfKUtUc69w22ChFxcbCWlyZ
         SQIq4WuTVvmcrmsKcoXh79PfeZ9aMBoi3C2skrHpQi+VsaSZGj7QDE6aHCjtoQ1vOkQ+
         xKYAPO9Bg/n05axPgADGdUM8aa49oaHW/FmeuG7/Bybx3xv19wkIysIG2ccRI8QmC3k1
         HZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=wOQwUV1OTdm8rXcXH3hd5vz3q5VPm4CSiBNP9xg+bxuQTiImE435cpHnfsUcLXnbDO
         vT7jT8f5BbKd1XmLxEZJQuQy8tmYrEq3ixsJ68Al90mIkeQBlElw29U3w0cw0Bz8cdAX
         dcJqGubBDx65K6dw6aD1bPKt7CFND4RuY6cZSOx4bFcnvDyWMShYScBMSnBgX3jy30vO
         wBvxBTbF2K407kbSU8ssE2v0EFFJx2yI93Q550hZZLbZfnJnoFDyl5eZRPHRFpjf4v2x
         aRJ26TlYRqsMCfJQMyAvQS36qrhgDyKx5gF1GyDIsAJI9hGa8OY1KdMRLwkGbu5IkCyo
         2EHg==
X-Gm-Message-State: ANoB5pkss1rDHYVM8NJK4LF6SJHYdKQjNvdFaXF7eM3Isj2NzO8cUvS7
        zQi0oaXeaCuRsV1+DZoSuZk+ASyScOVIKHV9cOc=
X-Google-Smtp-Source: AA0mqf48OcNfA1X0GHSPVFo9jKgJtFpw06nUWDzsaxPQqQMHhEitJ778Ezo5umfq7LbLF4bHDQSlg3UObqeEGI9bP9Y=
X-Received: by 2002:ac2:5e69:0:b0:4b5:8298:5861 with SMTP id
 a9-20020ac25e69000000b004b582985861mr4527074lfr.252.1670952528559; Tue, 13
 Dec 2022 09:28:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6500:a83:b0:179:db22:d024 with HTTP; Tue, 13 Dec 2022
 09:28:47 -0800 (PST)
Reply-To: canyeu298@gmail.com
From:   Can yeu <gaspercarter98@gmail.com>
Date:   Tue, 13 Dec 2022 18:28:47 +0100
Message-ID: <CAPOjZJBxEwy4tTUPxfRakGJHBD-dio931=YGWZUhLrTeCxOEqw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

-- 
Dear Friend,

I have an important message which i want to discuss with you.

Your Faithfully

Mrs Can Yeu
