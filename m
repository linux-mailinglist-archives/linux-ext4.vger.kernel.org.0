Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB46D14FADC
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Feb 2020 23:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBAWuF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 Feb 2020 17:50:05 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59123 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726518AbgBAWuF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 Feb 2020 17:50:05 -0500
Received: from callcc.thunk.org (75-104-86-204.mobility.exede.net [75.104.86.204] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 011MnpV2000422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Feb 2020 17:49:58 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1A129420324; Sat,  1 Feb 2020 17:49:51 -0500 (EST)
Date:   Sat, 1 Feb 2020 17:49:51 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     qiwuchen55@gmail.com
Cc:     adilger.kernel@dilger.ca, trivial@kernel.org,
        linux-ext4@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] ext4: remove trivial nowait check for buffered write
Message-ID: <20200201224951.GF528198@mit.edu>
References: <1580529639-26328-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580529639-26328-1-git-send-email-qiwuchen55@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Feb 01, 2020 at 12:00:39PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Remove trivial nowait check for ext4_buffered_write_iter(),
> since buffered writes will return -EINVAL if IOCB_NOWAIT
> passed in the follow-up function ext4_write_checks()->
> ext4_generic_write_checks()->generic_write_checks().
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

The reason why we do this check here is so that we return immediately
and not potentially block when we call inode_lock().  Otherwise, an
AIO request with IOCB_NOWAIT could block, and that's not allowed.

    	    	 	     	   	  - Ted
