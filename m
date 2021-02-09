Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ED93147A9
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Feb 2021 05:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBIEs3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Feb 2021 23:48:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40951 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229891AbhBIEs3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Feb 2021 23:48:29 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1194leK7027271
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 Feb 2021 23:47:41 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BF41415C39D8; Mon,  8 Feb 2021 23:47:40 -0500 (EST)
Date:   Mon, 8 Feb 2021 23:47:40 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/3] ext2fs: initialize handle to NULL in
 ext2fs_count_blks
Message-ID: <YCIT7PhGDBP8z5Dg@mit.edu>
References: <20210204233601.2369470-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204233601.2369470-1-harshads@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 04, 2021 at 03:35:59PM -0800, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> Initialize the handle to NULL to ensure that in error cases,
> ext2fs_free_mem can be called on it.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks, applied.

					- Ted
