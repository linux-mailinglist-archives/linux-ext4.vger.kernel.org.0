Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7805D2B021
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2019 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfE0IY7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 May 2019 04:24:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:56500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfE0IY7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 May 2019 04:24:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0870EAE82;
        Mon, 27 May 2019 08:24:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 46E7F1E3C0D; Mon, 27 May 2019 10:24:57 +0200 (CEST)
Date:   Mon, 27 May 2019 10:24:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Liu Song <fishland@aliyun.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, liu.song11@zte.com.cn
Subject: Re: [PATCH] jbd2: fix typo in comment of
 journal_submit_inode_data_buffers
Message-ID: <20190527082457.GA20440@quack2.suse.cz>
References: <20190525091251.3236-1-fishland@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525091251.3236-1-fishland@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 25-05-19 17:12:51, Liu Song wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> delayed/dealyed
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>

Thanks. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 150cc030b4d7..0395ca016235 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -184,7 +184,7 @@ static int journal_wait_on_commit_record(journal_t *journal,
>  /*
>   * write the filemap data using writepage() address_space_operations.
>   * We don't do block allocation here even for delalloc. We don't
> - * use writepages() because with dealyed allocation we may be doing
> + * use writepages() because with delayed allocation we may be doing
>   * block allocation in writepages().
>   */
>  static int journal_submit_inode_data_buffers(struct address_space *mapping)
> -- 
> 2.20.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
