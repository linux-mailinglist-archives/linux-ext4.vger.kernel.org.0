Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3F938C0C3
	for <lists+linux-ext4@lfdr.de>; Fri, 21 May 2021 09:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhEUHco (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 May 2021 03:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbhEUHco (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 May 2021 03:32:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBEBC061763
        for <linux-ext4@vger.kernel.org>; Fri, 21 May 2021 00:31:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so6811620wmk.1
        for <linux-ext4@vger.kernel.org>; Fri, 21 May 2021 00:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JX2NF0LoCNh+yd7JhxwHGPcUa2KSL8nXMCjUnyA43EQ=;
        b=HLSqPrUlVKEbMq4gNhA24tgksB7ufT4UkPI7YqExauQ/ge+h9EONOPdRmxRGyHW0wR
         rgcrc9o5Kzqg0FyZ9STQ+xakYdpAfWJRsos/PqFlZE1OPFLfNXSKSqZa4KsH4elN0yz5
         MkSk0ylgFE9Xh4Kfq2XNX5XJR+K81B+gEOm7AAiOUpCIo90jEEzS1ZtIo5RblXaKJmHT
         7cY996tQ5m9ZfDNjR1g213CLKVicglwB62OG6MFOCbkgT4dBdcXUrySWxffTGUfIjfx3
         6PqIW76fod2eibxzX5GbqW7c9Uv99BhEL238WZZ9lx1u/5zMtE9s1V0lgr6L0gaI86Un
         U8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JX2NF0LoCNh+yd7JhxwHGPcUa2KSL8nXMCjUnyA43EQ=;
        b=d06qmE4U8UjyEm4KS8qrGLHsA0ps3k9jeQMaQeabhuO0xDElWh1DkQneFlncctlcVm
         mi4o/5L2UfuovZy0Vxz10bDSul/h+iJO0sgbLcpVG3CyNmJlDenW7Y35K7LK3YPU4qmH
         yttZS+oPh3+SYqgXMDNNapyI3gvZvhtr+9nQfMySZ3tQ5giwR2YZF4bgqH/oEs49ZO7u
         4kbC15nusZ+HaQqhQ3g+hmv5tJL+1R15pkK00BYwCvvxVQyI2QfBiiEyiqkjR0wdP+0H
         SX8KlxtSTOJvUVcbDhIIeeM8iWeKP3yBhz41qtk5UPJ6sl7bVwEbBCYzq7vvHQ9aWVtX
         pbqg==
X-Gm-Message-State: AOAM532KHqellUKwBIAN0bdYgvSiJxiRqx0uxaAsn5HiInLRbJJGAOyZ
        Nu7/Mdebzu2tpi6T3pnM3QI+NA==
X-Google-Smtp-Source: ABdhPJyfiRwa7S9seGTK9XjC59dTlYZZjltqdtfRBktLHCxvxavP7B8Kq4aIvTPb1KcTdyMwAP8UYg==
X-Received: by 2002:a7b:cd01:: with SMTP id f1mr7712226wmj.177.1621582280129;
        Fri, 21 May 2021 00:31:20 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id n15sm1048718wrr.20.2021.05.21.00.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:31:19 -0700 (PDT)
Date:   Fri, 21 May 2021 08:31:17 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: ext4: mballoc: amend goto to cleanup groupinfo
 memory correctly
Message-ID: <YKdhxcVbevRJHb1q@equinox>
References: <YI0czH0auvWlU8bA@equinox>
 <6E6AEEB4-1FBA-40F1-8328-8E304E68A7C6@dilger.ca>
 <YI6DqtMHj9dx26Kw@equinox>
 <YKcuf0eYcMIELjEj@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKcuf0eYcMIELjEj@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 20, 2021 at 11:52:31PM -0400, Theodore Y. Ts'o wrote:
> Thanks, applied, with a cleaned up commit description.
> 
> Cheers,
> 
> 					- Ted

Dear Ted,

Thank you for applying the patch, appreciate it.

Regards,
Phil
