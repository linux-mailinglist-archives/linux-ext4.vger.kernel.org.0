Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 699AAD85C2
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2019 04:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfJPCOf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Oct 2019 22:14:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55086 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729448AbfJPCOf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Oct 2019 22:14:35 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9G2ESlC012546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 22:14:30 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E7DCA420458; Tue, 15 Oct 2019 22:14:27 -0400 (EDT)
Date:   Tue, 15 Oct 2019 22:14:27 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH v3 01/13] ext4: add handling for extended mount options
Message-ID: <20191016021427.GA31394@mit.edu>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-2-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001074101.256523-2-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 01, 2019 at 12:40:50AM -0700, Harshad Shirwadkar wrote:
> @@ -1858,8 +1863,9 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
>  			set_opt2(sb, EXPLICIT_DELALLOC);
>  		} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
>  			set_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM);
> -		} else
> +		} else if (m->mount_opt) {
>  			return -1;
> +		}
>  	}
>  	if (m->flags & MOPT_CLEAR_ERR)
>  		clear_opt(sb, ERRORS_MASK);

Why is this change needed?  This is in the handling of options that
have MOPT_EXPLICIT, and it doesn't seem relevant to this commit?

     		    	   	   		 - Ted
