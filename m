Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5AED9882
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2019 19:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbfJPRan (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Oct 2019 13:30:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41036 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728901AbfJPRan (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Oct 2019 13:30:43 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9GHUd72005593
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 13:30:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1BF94420458; Wed, 16 Oct 2019 13:30:39 -0400 (EDT)
Date:   Wed, 16 Oct 2019 13:30:39 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] jbd2: fast-commit recovery path changes
Message-ID: <20191016173039.GE11103@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-6-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001074101.256523-6-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 01, 2019 at 12:40:54AM -0700, Harshad Shirwadkar wrote:
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 14d549445418..e0684212384d 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
>  
>  	jbd2_write_superblock(journal, write_op);
>  
> +	if (had_fast_commit)
> +		jbd2_set_feature_fast_commit(journal);
> +

Why the logic with had_fast_commit and (re-)setting the fast commit
feature flag?

This ties back to how we handle the logic around setting the fast
commit flag if requested by the file system....

> @@ -768,6 +816,8 @@ static int do_one_pass(journal_t *journal,
>  			if (err)
>  				goto failed;
>  			continue;
> +		case JBD2_FC_BLOCK:
> +			continue;

Why should a Fast Commit block ever show up in the primary part of the
journal?   It should never happen, right?

In which case, we should probably at least issue a warning, and not
just skip the block.

					- Ted
