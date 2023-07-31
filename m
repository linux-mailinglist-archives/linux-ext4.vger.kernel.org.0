Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903A2769196
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jul 2023 11:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjGaJXG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jul 2023 05:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjGaJWI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 Jul 2023 05:22:08 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C36118C
        for <linux-ext4@vger.kernel.org>; Mon, 31 Jul 2023 02:20:07 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a4875e65a3so2906390b6e.2
        for <linux-ext4@vger.kernel.org>; Mon, 31 Jul 2023 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690795205; x=1691400005;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8jBdzLQJ+ZLP+jbMf7tETdvXCRLEIi7fVyBcUhx2BTg=;
        b=Bdwz9Y0wQHMxVwXK8xqcL/6Pvj2xREuvLjJFXw3ups7PK8CbWbTNGqo3q2D8SLd9/C
         3MmAzNxyVnAZQe2wkyICVIrZLvqQYKHn/LSzDiDDEwxHXmYY7oGdbL/TCqO5cWTVztuS
         h6X6z8X7Wn+eeTnScPZoK0MhNvqtwGWMai85kRPuNfR18qrvpzFs4ngIopkQy/kcrYve
         wzOXoUxl2XlXVK2nIEB8qL+tiRHnMNLSIUwOqVvDor1zwhBxU+7XBvsnR3ZcqHWDfeET
         O56b+aAVVzA22ujZ4gm4D5clU9GkGKurjGFo+DdF1QkpJPAxJOGH3spzmQQhr8tid0lP
         qlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690795205; x=1691400005;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jBdzLQJ+ZLP+jbMf7tETdvXCRLEIi7fVyBcUhx2BTg=;
        b=MyaPb1wQz1789IhHzdKZ+UFJR0181J0oY50MCqnOLbb4QPd0UjUU0aEsxrUnAXz5oA
         zi2Hx89uA8uhly0DSsaCi9jr7hwRK2kYhjPl2DfofmPZ4rIcqVjfYZgPIqRtrCvtkxQc
         ASCgSuYnHdGtkQS8OPGWGB/zh0ghHxA0J2i2Q13i4m2WkvzAmh0kl62xdJvtWDWgyKe+
         atNmmuIFMMuabiyqtSusI6EVi6DjKROx2fjHYeaYd4BKBMEHmFrTkMy6uTiYjgtXEi67
         nTzPQ3bB7t3/xpxRXI9DkhmvLjvznhn5o6JA27DA5YvDVWHRubVB5IgzUon83HOaBfur
         wp0g==
X-Gm-Message-State: ABy/qLYYvJuHo8dK+PNlHfdxB466Xu3Xr8MBv7GoD9i3gIg7tG0iGYXO
        PYGQqfXKs/Nz7fNhW2DNv54=
X-Google-Smtp-Source: APBJJlEk5M23CN9YxU1VX5sV8lrXUObPRDezT83G8kARrN5tPDSyW43qESfQk0xBpdPwYiFFoCxtvw==
X-Received: by 2002:a05:6808:220d:b0:3a7:1962:d7ff with SMTP id bd13-20020a056808220d00b003a71962d7ffmr4935469oib.57.1690795204734;
        Mon, 31 Jul 2023 02:20:04 -0700 (PDT)
Received: from dw-tp ([129.41.58.23])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a19c900b00267c49d74e8sm8193010pjj.42.2023.07.31.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:20:04 -0700 (PDT)
Date:   Mon, 31 Jul 2023 14:49:56 +0530
Message-Id: <87y1iwwi83.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Wang Jianjian <wangjianjian0@foxmail.com>,
        linux-ext4@vger.kernel.org
Cc:     wangjianjian0@foxmail.com
Subject: Re: [PATCH] jbd2: Remove unused t_handle_lock
In-Reply-To: <tencent_DBB7534F4FC71E2788D13206DA966281D806@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Wang Jianjian <wangjianjian0@foxmail.com> writes:

> Since commit f7f497cb7024 ("jbd2: kill t_handle_lock
> transaction spinlock"), this lock has been no use.
>
Thanks for catching it. We should add fixes tag too.

Fixes: f7f497cb7024 ("jbd2: kill t_handle_lock transaction spinlock")

With that feel free to add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh
