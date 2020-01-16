Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A9213DE56
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2020 16:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgAPPMx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jan 2020 10:12:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36308 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726151AbgAPPMx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jan 2020 10:12:53 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00GFCe9c029404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 10:12:43 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 68A044207DF; Thu, 16 Jan 2020 10:12:39 -0500 (EST)
Date:   Thu, 16 Jan 2020 10:12:39 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ext4: Rename ext4_kvmalloc() to
 ext4_kvmalloc_nofs() and drop its flags argument
Message-ID: <20200116151239.GA253859@mit.edu>
References: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
 <20191227080523.31808-3-naoto.kobayashi4c@gmail.com>
 <20200113223237.GL76141@mit.edu>
 <20200116123724.GD8446@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116123724.GD8446@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 16, 2020 at 01:37:24PM +0100, Jan Kara wrote:
> 
> Ted, I don't think this patch is needed at all - see my email [1]. Sadly
> Naoto didn't reply to my question whether he really saw any deadlock /
> lockdep splat or whether it was just a theoretical concern he had...

Thanks, good point.  So what we should do instead is just drop
ext4_kvmalloc() entirely.

						- Ted
