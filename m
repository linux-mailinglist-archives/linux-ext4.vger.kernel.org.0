Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02439A8410
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2019 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfIDNCP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Sep 2019 09:02:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37403 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727929AbfIDNCP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Sep 2019 09:02:15 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-96.corp.google.com [104.133.0.96] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x84D29pR023350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Sep 2019 09:02:11 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2D04142049E; Wed,  4 Sep 2019 09:02:09 -0400 (EDT)
Date:   Wed, 4 Sep 2019 09:02:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     zhao.hang1@zte.com.cn
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn
Subject: Re: [PATCH] fs:ext4:remove unused including <linux/version.h>
Message-ID: <20190904130209.GB3044@mit.edu>
References: <201909041536282215333@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909041536282215333@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 04, 2019 at 03:36:28PM +0800, zhao.hang1@zte.com.cn wrote:
> fix compiler error in ext4.hfs/ext4/ext4.h:30:27: fatal error: linux/version.h: No such file or directorySigned-off-by: Zhao Hang <zhao.hang1@zte.com.cn> --- fs/ext4/ext4.h | 1 - 1 file changed, 1 deletion(-)diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.hindex 1cb6785..9baa4cf 100644--- a/fs/ext4/ext4.h+++ b/fs/ext4/ext4.h@@ -27,7 +27,6 @@ #include <linux/seqlock.h>  #include <linux/mutex.h>  #include <linux/timer.h> -#include <linux/version.h>  #include <linux/wait.h>  #include <linux/sched/signal.h>  #include <linux/blockgroup_lock.h> --  2.15.2

First of all, this patch is completely white space namaged.

Secondly, this is a problem in how you are building your kernel (or
ext4 as a module, if you are trying to build ext4 as some kind of out
of tree module or some such).  When you do a kernel build, the file
include/linux/version.h is automatically generated.  It will look
something like this.

% cat /build/ext4-64/usr/include/linux/version.h
#define LINUX_VERSION_CODE 327936
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

			      	       	     - Ted
