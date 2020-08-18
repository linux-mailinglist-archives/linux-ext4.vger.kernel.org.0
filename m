Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40236248354
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 12:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHRKs1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 06:48:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgHRKs1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 18 Aug 2020 06:48:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2BF6BB6AB;
        Tue, 18 Aug 2020 10:48:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0C7861E12CB; Tue, 18 Aug 2020 12:48:26 +0200 (CEST)
Date:   Tue, 18 Aug 2020 12:48:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        linfeilong@huawei.com
Subject: Re: [PATCH] jbd2: remove useless variable chksum_seen in do_one_pass
Message-ID: <20200818104826.GA1902@quack2.suse.cz>
References: <20200811022128.32690-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811022128.32690-1-luoshijie1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 10-08-20 22:21:28, Shijie Luo wrote:
> This variable only indicates that we do checksum success, while
> chksum_err can also do. Moreover, condition "!chksum_seen" in else
> if bracket is pointless.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>

Thanks for the patch! Some comments below.

> @@ -709,11 +707,10 @@ static int do_one_pass(journal_t *journal,
>  				    cbh->h_chksum_type == JBD2_CRC32_CHKSUM &&
>  				    cbh->h_chksum_size ==
>  						JBD2_CRC32_CHKSUM_SIZE)
> -				       chksum_seen = 1;
> +				       chksum_err = 0;
>  				else if (!(cbh->h_chksum_type == 0 &&
>  					     cbh->h_chksum_size == 0 &&
> -					     found_chksum == 0 &&
> -					     !chksum_seen))
> +					     found_chksum == 0))
>  				/*
>  				 * If fs is mounted using an old kernel and then
>  				 * kernel with journal_chksum is used then we

I agree the use of chksum_err & chksum_seen looks rather arbitrary. In fact
the code seems to be equivalent to:

				/* Neither checksum match nor unused? */
				if (!(crc32_sum == found_chksum &&
                                     cbh->h_chksum_type == JBD2_CRC32_CHKSUM &&
                                     cbh->h_chksum_size ==
                                                JBD2_CRC32_CHKSUM_SIZE) &&
				    !(cbh->h_chksum_type == 0 &&
                                             cbh->h_chksum_size == 0 &&
                                             found_chksum == 0)) {
					info->end_transaction = next_commit_ID;
					if (jbd2_has_feature_async_commit(journal)) {
						...
					}
				}
				crc32_sum = ~0;

which would be even simpler...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
