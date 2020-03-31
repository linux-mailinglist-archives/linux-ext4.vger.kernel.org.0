Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8251B1999C2
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Mar 2020 17:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgCaPe1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Mar 2020 11:34:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgCaPe0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Mar 2020 11:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:
        Subject:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=VB7oY+kToObAeb+RWYhI8HAQY5Z0sfc+SL5ownpJMKg=; b=YeDrIxjhKmSX16ao4QoVS5GUCY
        1pj8CQLojek0kSJHSC+KQWvQh9eO4OQTjO7hE6XVDLKeU6G+x332Lgg8rCnaAtbG4JwOZ458grgJ0
        1TFi7/dPIgFWcGwFBwg+IVggWHhrBGqxHLMYBpzQnhV9qFsXjB95vUXexIHechY0R1laxkaf5okU1
        /mKbu4NhR5zutADBbLql3UGxoVUcAdx3NVEtEEj8JTKqNtfYIdNZQh+5eVnycOv9iiCPo6zTTuGuV
        BKeYuS41+IecYiMaMwKRDV+eWcB+HnZizctgF/EDx2MlHufkqIPDS768Sk/+a0KsJ3kr45jPdSrfp
        HDvru5PQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJIuH-0007Pi-Pe; Tue, 31 Mar 2020 15:34:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Mar 31 (fs/ext4)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
References: <20200331201009.5572e93b@canb.auug.org.au>
Message-ID: <099e56ee-138a-519e-4a68-5ea18732ff11@infradead.org>
Date:   Tue, 31 Mar 2020 08:34:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331201009.5572e93b@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 3/31/20 2:10 AM, Stephen Rothwell wrote:
> Hi all,
> 
> The merge window has opened, so please do not add any material for the
> next release into your linux-next included trees/branches until after
> the merge window closes.
> 
> Changes since 20200330:
> 


on i386 or x86_64:
when
# CONFIG_PRINTK is not set

../fs/ext4/balloc.c: In function ‘ext4_wait_block_bitmap’:
../fs/ext4/balloc.c:519:3: error: implicit declaration of function ‘ext4_error_err’; did you mean ‘ext4_error’? [-Werror=implicit-function-declaration]
   ext4_error_err(sb, EIO, "Cannot read block bitmap - "
   ^~~~~~~~~~~~~~
   ext4_error


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
