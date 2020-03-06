Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2917B5C1
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2020 05:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCFEeS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 23:34:18 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48037 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726251AbgCFEeS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 23:34:18 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0264YCcg025240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Mar 2020 23:34:12 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0A1C542045B; Thu,  5 Mar 2020 23:34:12 -0500 (EST)
Date:   Thu, 5 Mar 2020 23:34:12 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix a data race at inode->i_disksize
Message-ID: <20200306043412.GN20967@mit.edu>
References: <1582556566-3909-1-git-send-email-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582556566-3909-1-git-send-email-hqjagain@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 24, 2020 at 11:02:46PM +0800, Qiujun Huang wrote:
> KCSAN find inode->i_disksize could be accessed concurrently.
> 
> BUG: KCSAN: data-race in ext4_mark_iloc_dirty / ext4_write_end
> ...

Thanks, applied.

					- Ted
