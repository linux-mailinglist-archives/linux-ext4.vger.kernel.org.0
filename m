Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C9A297C9E
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Oct 2020 15:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761771AbgJXNiv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Oct 2020 09:38:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34178 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761769AbgJXNiu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Oct 2020 09:38:50 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kWJku-0000ri-NB
        for linux-ext4@vger.kernel.org; Sat, 24 Oct 2020 13:38:48 +0000
Received: by mail-wm1-f69.google.com with SMTP id s25so1610789wmj.7
        for <linux-ext4@vger.kernel.org>; Sat, 24 Oct 2020 06:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RDRwq8+3VpThffYJtXt/v2rYH+3Mm1/lRXG8WvQsfX8=;
        b=U8GMAvPyZc9xWkEbJI72fdn4O+sC4nx9KKIyEUIJW9zkvV0s1bBlGr3XP9/+o0tfni
         sS9dLVOlUN77rfQnjB/j2w6vyQK77Gq27H7oyqPTV0Gvzrjr/mJFpirIWxcAZWQB4HZY
         RSZkCxzTGoXmU2gnpQCS6HsHRfgcC79+Dyi6AbUWW7lISP7JruwKlMHqapR8MPiOh5K1
         abQQQh++UHG1+IIdjl6NRuE2t2nNw7VIvE8KH/Xi/doaOTEJxmy0NM1Mdr9pflWFVHwE
         LVujS3JZu8IZGV0hvLWGCrJQFvPdbT+9XMujQ0R6A1STsT1B+/oyL0JUQfwgQFxLHPHl
         ASjQ==
X-Gm-Message-State: AOAM533hPkgofKSB75iXnsDhe2/Lvn/586azAniIJJI15XeOPQ9S/9rj
        0euos24evhr3KIbtww9yU+MRoNJHIzjMSSgWHQknbwEd4TGB5Ig5kQnACbsDwAyiUofkK+tVm8I
        FTtFq+USvlLX6O9Zy2nWTk+DqBEIIZVjap9T3nKs=
X-Received: by 2002:a1c:9695:: with SMTP id y143mr6623607wmd.146.1603546728001;
        Sat, 24 Oct 2020 06:38:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2E7LrJHN/ax9a42WqsByu0neKeFDFF22hpeLgIQ06+1FEVSmOr//XRtzNPnWYirII/z/lgw==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr6623590wmd.146.1603546727785;
        Sat, 24 Oct 2020 06:38:47 -0700 (PDT)
Received: from localhost (host-79-33-123-6.retail.telecomitalia.it. [79.33.123.6])
        by smtp.gmail.com with ESMTPSA id m12sm9937844wmi.33.2020.10.24.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 06:38:47 -0700 (PDT)
Date:   Sat, 24 Oct 2020 15:38:46 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: swap file broken with ext4 fast-commit
Message-ID: <20201024133846.GA33750@xps-13-7390>
References: <20201024131333.GA32124@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024131333.GA32124@xps-13-7390>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Oct 24, 2020 at 03:13:37PM +0200, Andrea Righi wrote:
> I'm getting the following error if I try to create and activate a swap
> file defined on an ext4 filesystem:
> 
>  [   34.406479] swapon: file is not committed
> 
> The swap file is created in the root filesystem (ext4 mounted with the
> following options):
> 
> $ grep " / " /proc/mounts
> /dev/vda1 / ext4 rw,relatime 0 0
> 
> No matter how long I wait or how many times I run sync, I'm still
> getting the same error and the swap file is never activated.
> 
> A git bisect shows that this issue has been introduced by the following
> commit:
> 
>  aa75f4d3daae ("ext4: main fast-commit commit path")
> 
> Simple test case to reproduce the problem:
> 
>  # fallocate -l 8G /swapfile
>  # chmod 0600 /swapfile
>  # mkswap /swapfile
>  # swapon /swapfile
> 
> Maybe we're missing to mark the inode as clean somewhere, even if the
> transation is committed to the journal?

I think I see the problem. There's something wrong in
ext4_inode_datasync_dirty(), it looks like the logic to check if the
inode is dirty is quite the opposite.

I'll test and send a patch soon.

-Andrea
