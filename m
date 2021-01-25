Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC73031F5
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jan 2021 03:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbhAYQqd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Jan 2021 11:46:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:60924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730558AbhAYQoU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 25 Jan 2021 11:44:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A424AD4E;
        Mon, 25 Jan 2021 14:54:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D570B1E14B3; Mon, 25 Jan 2021 15:54:48 +0100 (CET)
Date:   Mon, 25 Jan 2021 15:54:48 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] jbd2: introduce some new log interfaces
Message-ID: <20210125145448.GG1175@quack2.suse.cz>
References: <cover.1611402263.git.brookxu@tencent.com>
 <f19b925451351040a7e831bb1c96f062421c8ce8.1611402263.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19b925451351040a7e831bb1c96f062421c8ce8.1611402263.git.brookxu@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 23-01-21 20:00:44, Chunguang Xu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> Compared to directly using numbers to indicate levels, using abstract
> error, warn, notice, info, debug to indicate levels may be more
> convenient for code reading and writing. Similar to other kernel
> modules, some basic log interfaces are introduced.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

One more thing I've noticed when reading this patch:

> +
> +#ifdef CONFIG_JBD2_DEBUG
> +/*
> + * Define JBD2_EXPENSIVE_CHECKING to enable more expensive internal
> + * consistency checks.  By default we don't do this unless
> + * CONFIG_JBD2_DEBUG is on.
> + */
> +#define JBD2_EXPENSIVE_CHECKING
> +extern ushort jbd2_journal_enable_debug;
> +void jbd2_log(int level, journal_t *j, const char *file, const char *func,
> +		      unsigned int line, const char *fmt, ...);
> +
> +#define JBD2_ERR	1	/* error conditions */
> +#define JBD2_WARN	2	/* warning conditions */
> +#define JBD2_NOTICE	3	/* normal but significant condition */
> +#define JBD2_INFO	4	/* informational */
> +#define JBD2_DEBUG	5	/* debug-level messages */

This is actually not true. All the jbd_debug() messages are really debug
messages, not errors, not warnings. It is just a different level of detail.
Honestly, these days, I'd rather discard all the levels, use pr_debug()
function to print these messages inside jdb2_debug() and defer to
CONFIG_DYNAMIC_DEBUG framework for configuration of which messages are
interesting for a particular debug session.

								Honza

> +
> +#define jbd2_err(j, fmt, a...)						\
> +	jbd2_log(JBD2_ERR, j, __FILE__, __func__, __LINE__, (fmt), ##a)
> +
> +#define jbd2_warn(j, fmt, a...)						\
> +	jbd2_log(JBD2_WARN, j, __FILE__, __func__, __LINE__, (fmt), ##a)
> +
> +#define jbd2_notice(j, fmt, a...)					\
> +	jbd2_log(JBD2_NOTICE, j, __FILE__, __func__, __LINE__, (fmt), ##a)
> +
> +#define jbd2_info(j, fmt, a...)						\
> +	jbd2_log(JBD2_INFO, j, __FILE__, __func__, __LINE__, (fmt), ##a)
> +
> +#define jbd2_debug(j, fmt, a...)					\
> +	jbd2_log(JBD2_DEBUG, j, __FILE__, __func__, __LINE__, (fmt), ##a)
> +
> +#else
> +
> +#define jbd2_err(j, fmt, a...)
> +#define jbd2_warn(j, fmt, a...)
> +#define jbd2_notice(j, fmt, a...)
> +#define jbd2_info(j, fmt, a...)
> +#define jbd2_debug(j, fmt, a...)
> +
> +#endif
>  #endif
>  
>  /*
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
