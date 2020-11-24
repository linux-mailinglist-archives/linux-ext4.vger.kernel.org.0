Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455362C1B52
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 03:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgKXCMx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 21:12:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40210 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726376AbgKXCMx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 21:12:53 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AO2Ciua032401
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 21:12:45 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9B731420136; Mon, 23 Nov 2020 21:12:44 -0500 (EST)
Date:   Mon, 23 Nov 2020 21:12:44 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Wang Shilong <wshilong@ddn.com>,
        jenkins <devops@whamcloud.com>, Maloo <maloo@whamcloud.com>,
        Andreas Dilger <adilger@whamcloud.com>
Subject: Re: [RFC PATCH v3 50/61] e2fsck: move ext2fs_get_avg_group to
 rw_bitmaps.c
Message-ID: <20201124021244.GM132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-51-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-51-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:39:36AM -0800, Saranya Muruganandam wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> A bounch of ext2fs_get_avg_group() unused warning messages are
> annoying, move it to rw_bitmaps.c to make gcc happy.

This should be merged with the commit that initially defined
ext2fs_get_avg_group() in the first place.

More generally, *all* of the "fix *" commits should be merged with the
original commits.  This will make it **so** much easier to review the
commits.

							- Ted
