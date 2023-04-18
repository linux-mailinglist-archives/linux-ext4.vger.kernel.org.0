Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685F86E58D9
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Apr 2023 07:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjDRF7Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Apr 2023 01:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDRF7O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Apr 2023 01:59:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989585596
        for <linux-ext4@vger.kernel.org>; Mon, 17 Apr 2023 22:59:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4ec8133c59eso1875759e87.0
        for <linux-ext4@vger.kernel.org>; Mon, 17 Apr 2023 22:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681797551; x=1684389551;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=B/lJxYxd9QgPHdTz8Y94+SQwigHwPQz1MSY0HBGE49jeKpZvQ5ridodaJ1/hg5dYTg
         xfm1UctNbPOooHeryL4EpFSpzLbpfIM/1AP6IiE/eAQ2XC+jiAPE4sjVq/0OLp+s5H64
         OPszLw7mQaJ1PqKU00ScUiZOb3Ks0WeXpBGa5YCNLjOyLXsRt33eVOV3J7/7jSzM1Fi3
         /RpCf1VKsRTVD/tqHSDxBWAwYQ/D3zBjMwphUFrVmu8iFcvUlk1YDipJso9tURLsGQAs
         Kxkqmj8wx1BzA1Zw3ty0py3y/B5zl4OJTEDWjPXGFVRp+Onsg5ZfmKZ52/USaH6DILFS
         M1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681797551; x=1684389551;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=ikhfRlGCTLhBAUQkgvB9nCKph9hzdKrN+gZ2cZcmjojBdaLPr8cLc4FLCn1gUn9X1i
         pbb/NLE3EjTogmQjeejCcBJP001pIGFPyQp/Z5BFEMjN7OC0gmpkLkKRSs1oubZhBnHs
         QN/8dA5cWzkItl75p0FP0zP18iZVbAlY3rvWh5/CS/KdQvXwzceJdzeV0GQlGyPF1faR
         2eGPkHIQipOWcoLKLqFrklpkQzfNMwilpA6V1M64uy/oiw8HZA5/8gRnngioWwiSq1vs
         QWw0AeAyWyAOkB6ez3JPymEW/CZT4K2vvShwaJTaLhYB3OTjEWVl/o3aIPR0XUUP7s1s
         x2Xw==
X-Gm-Message-State: AAQBX9ftki0QEUz7FB6xq6SyKDJ7k8O4D3T1wX8v2oVqUz9pP3DnSCjD
        0yjg7nKGyoCT9RPn4zXoGp1VJpKQUWprDK2OHSQ=
X-Google-Smtp-Source: AKy350YRsUSKQ0+i58Lzun7WtY7IrRwSkm+DWIi2JdfS71rVYYWUT2OQ/a/Q5PRWIBazn3AQLm2dWBYGVxBajLvvRoE=
X-Received: by 2002:a05:6512:96b:b0:4e8:4b7a:6b73 with SMTP id
 v11-20020a056512096b00b004e84b7a6b73mr2935594lft.4.1681797550844; Mon, 17 Apr
 2023 22:59:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:2681:0:b0:1b6:840f:9075 with HTTP; Mon, 17 Apr 2023
 22:59:10 -0700 (PDT)
Reply-To: mariamkouame.info@myself.com
From:   Mariam Kouame <mariamkouame1992@gmail.com>
Date:   Mon, 17 Apr 2023 22:59:10 -0700
Message-ID: <CADUz=agNY633M0qMXMnAP3Ms7-3rKuWtAZGCOQZKeYpCdBxT_w@mail.gmail.com>
Subject: from mariam kouame
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Mariam Kouame
