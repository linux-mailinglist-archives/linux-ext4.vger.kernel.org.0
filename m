Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BBAF6716
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Nov 2019 04:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfKJDha (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 9 Nov 2019 22:37:30 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38220 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbfKJDha (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 9 Nov 2019 22:37:30 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAA3bNv8007819
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 9 Nov 2019 22:37:24 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BE0144202FD; Sat,  9 Nov 2019 22:37:22 -0500 (EST)
Date:   Sat, 9 Nov 2019 22:37:22 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/2] e2scrub: fix some problems
Message-ID: <20191110033722.GE23325@mit.edu>
References: <157291884852.328601.5452592601628272222.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157291884852.328601.5452592601628272222.stgit@magnolia>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 04, 2019 at 05:54:08PM -0800, Darrick J. Wong wrote:
> Hi all,
> 
> Fix a couple of problems that have been reported against e2scrub_all.
> The first fixes a complaint about a large increase in boot time due to
> automatic reaping of e2scrub snapshots.  The second eliminates some
> broken hackery around loop iteration in bash.
> 
> This is an extraordinary way to destroy everything.  Enjoy!
> Comments and questions are, as always, welcome.

Thanks, look good.  I've applied this to the e2fsprogs maint branch.

	     	    	 	      - Ted
