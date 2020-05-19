Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA1D1DA109
	for <lists+linux-ext4@lfdr.de>; Tue, 19 May 2020 21:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgESTbr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 May 2020 15:31:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45901 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726059AbgESTbr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 May 2020 15:31:47 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04JJVfG0008218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 15:31:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B9BA5420304; Tue, 19 May 2020 15:31:41 -0400 (EDT)
Date:   Tue, 19 May 2020 15:31:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] ext4: don't ignore return values from ext4_ext_dirty()
Message-ID: <20200519193141.GG2396055@mit.edu>
References: <20200427013438.219117-1-harshadshirwadkar@gmail.com>
 <20200427013438.219117-2-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427013438.219117-2-harshadshirwadkar@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Apr 26, 2020 at 06:34:38PM -0700, Harshad Shirwadkar wrote:
> Don't ignore return values from ext4_ext_dirty, since the errors
> indicate valid failures below Ext4.  In all of the other instances of
> ext4_ext_dirty calls, the error return value is handled in some
> way. This patch makes those remaining couple of places to handle
> ext4_ext_dirty errors as well. In case of ext4_split_extent_at(), the
> ignorance of return value is intentional. The reason is that we are
> already in error path and there isn't much we can do if ext4_ext_dirty
> returns error. This patch adds a comment for that case explaining why
> we ignore the return value.
> 
> In the longer run, we probably should
> make sure that errors from other mark_dirty routines are handled as
> well.
> 
> Ran gce-xfstests smoke tests and verified that there were no
> regressions.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
