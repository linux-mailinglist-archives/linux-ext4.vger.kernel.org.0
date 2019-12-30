Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E012D261
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2019 18:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfL3RGk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 12:06:40 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60404 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726675AbfL3RGj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 12:06:39 -0500
Received: from callcc.thunk.org ([173.239.199.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBUH6Tfw022174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 12:06:31 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8F515420485; Mon, 30 Dec 2019 12:06:28 -0500 (EST)
Date:   Mon, 30 Dec 2019 12:06:28 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger@dilger.ca, lixi@ddn.com,
        wshilong@ddn.com
Subject: Re: [PATCH 2/2] e2fsck: fix use after free in calculate_tree()
Message-ID: <20191230170628.GB125106@mit.edu>
References: <1574759039-7429-1-git-send-email-wangshilong1991@gmail.com>
 <1574759039-7429-2-git-send-email-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574759039-7429-2-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 26, 2019 at 06:03:59PM +0900, Wang Shilong wrote:
> @@ -725,12 +728,18 @@ static errcode_t calculate_tree(ext2_filsys fs,
>  					return retval;
>  			}
>  			if (c3 == 0) {
> +				int delta1 = int_offset;;
> +				int delta2 = (char *)root - outdir->buf;
> +
>  				retval = alloc_blocks(fs, &limit, &int_ent,
>  						      &dx_ent, &int_offset,
>  						      NULL, outdir, i, &c2,
>  						      &c3);
>  				if (retval)
>  					return retval;
> +				/* outdir->buf might be reallocated */
> +				int_limit = (struct ext2_dx_countlimit *)(outdir->buf + delta1);
> +				root = (struct ext2_dx_entry *)(outdir->buf + delta2);
>  
>  			}
>  			dx_ent->block = ext2fs_cpu_to_le32(i);

Um, are you sure

				int delta1 = int_offset;;

is correct?  I would think
				int delta1 = (char *)int_limit - outdir->buf;

is what is needed; it's certainly much more clear.

   	   	   		       	    - Ted
