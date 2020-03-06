Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1852817B3CC
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2020 02:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFBdK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 20:33:10 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42703 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbgCFBdK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 20:33:10 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0261WxcD006661
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Mar 2020 20:32:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F3BC242045B; Thu,  5 Mar 2020 20:32:58 -0500 (EST)
Date:   Thu, 5 Mar 2020 20:32:58 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     fstests@vger.kernel.org, guaneryu@gmail.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4/021: make sure the fdatasync subprocess exits
Message-ID: <20200306013258.GL20967@mit.edu>
References: <20200226032256.10978-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226032256.10978-1-yi.zhang@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 26, 2020 at 11:22:56AM +0800, zhangyi (F) wrote:
> Now we just kill fdatasync_work process and wait nothing after the
> test, so a busy unmount failure may appear if the fdatasync syscall
> doesn't return in time.
> 
>   umount: /tmp/scratch: target is busy.
>   mount: /tmp/scratch: /dev/sdb already mounted on /tmp/scratch.
>   !!! failed to remount /dev/sdb on /tmp/scratch
> 
> This patch wait the xfs_io fdatasync subprocess exit to make sure
> _check_scratch_fs success.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Looks good, thanks!

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

