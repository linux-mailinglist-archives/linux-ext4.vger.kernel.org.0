Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2722917AFF1
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2020 21:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEUtm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 15:49:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48976 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbgCEUtm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 15:49:42 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 025KnVPZ005594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Mar 2020 15:49:32 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E6F7042045B; Thu,  5 Mar 2020 15:49:30 -0500 (EST)
Date:   Thu, 5 Mar 2020 15:49:30 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: code cleanup for ext4_statfs_project()
Message-ID: <20200305204930.GD20967@mit.edu>
References: <20200210082445.2379-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210082445.2379-1-cgxu519@mykernel.net>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 10, 2020 at 04:24:45PM +0800, Chengguang Xu wrote:
> Calling min_not_zero() to simplify complicated prjquota
> limit comparison in ext4_statfs_project().
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks, applied.

					- Ted
