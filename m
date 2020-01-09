Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E54C135544
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 10:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgAIJMs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 04:12:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:46238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgAIJMs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 Jan 2020 04:12:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D44E4B4A6;
        Thu,  9 Jan 2020 09:12:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 68BFE1E0CB5; Thu,  9 Jan 2020 10:12:40 +0100 (CET)
Date:   Thu, 9 Jan 2020 10:12:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: export information about first/last errors via
 /sys/fs/ext4/<dev>
Message-ID: <20200109091240.GA27035@quack2.suse.cz>
References: <20191224000541.88473-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224000541.88473-1-tytso@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 23-12-19 19:05:41, Theodore Ts'o wrote:
> Make {first,last}_error_{ino,block,line,func,errcode} available via
> sysfs.
> 
> Also add a missing newline for {first,last}_error_time.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'm just wondering a bit why do you need this? Some system monitoring
thing?

								Honza

> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index a990d28d191b..d218ebdafa4a 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -30,6 +30,9 @@ typedef enum {
>  	attr_feature,
>  	attr_pointer_ui,
>  	attr_pointer_ul,
> +	attr_pointer_u64,
> +	attr_pointer_u8,
> +	attr_pointer_string,
>  	attr_pointer_atomic,
>  	attr_journal_task,
>  } attr_id_t;
> @@ -47,6 +50,7 @@ struct ext4_attr {
>  	struct attribute attr;
>  	short attr_id;
>  	short attr_ptr;
> +	unsigned short attr_size;
>  	union {
>  		int offset;
>  		void *explicit_ptr;
> @@ -155,9 +159,29 @@ static struct ext4_attr ext4_attr_##_name = {			\
>  	},							\
>  }
>  
> +#define EXT4_ATTR_STRING(_name,_mode,_size,_struct,_elname)	\
> +static struct ext4_attr ext4_attr_##_name = {			\
> +	.attr = {.name = __stringify(_name), .mode = _mode },	\
> +	.attr_id = attr_pointer_string,				\
> +	.attr_size = _size,					\
> +	.attr_ptr = ptr_##_struct##_offset,			\
> +	.u = {							\
> +		.offset = offsetof(struct _struct, _elname),\
> +	},							\
> +}
> +
>  #define EXT4_RO_ATTR_ES_UI(_name,_elname)				\
>  	EXT4_ATTR_OFFSET(_name, 0444, pointer_ui, ext4_super_block, _elname)
>  
> +#define EXT4_RO_ATTR_ES_U8(_name,_elname)				\
> +	EXT4_ATTR_OFFSET(_name, 0444, pointer_u8, ext4_super_block, _elname)
> +
> +#define EXT4_RO_ATTR_ES_U64(_name,_elname)				\
> +	EXT4_ATTR_OFFSET(_name, 0444, pointer_u64, ext4_super_block, _elname)
> +
> +#define EXT4_RO_ATTR_ES_STRING(_name,_elname,_size)			\
> +	EXT4_ATTR_STRING(_name, 0444, _size, ext4_super_block, _elname)
> +
>  #define EXT4_RW_ATTR_SBI_UI(_name,_elname)	\
>  	EXT4_ATTR_OFFSET(_name, 0644, pointer_ui, ext4_sb_info, _elname)
>  
> @@ -202,6 +226,16 @@ EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
>  EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
>  #endif
>  EXT4_RO_ATTR_ES_UI(errors_count, s_error_count);
> +EXT4_RO_ATTR_ES_U8(first_error_errcode, s_first_error_errcode);
> +EXT4_RO_ATTR_ES_U8(last_error_errcode, s_last_error_errcode);
> +EXT4_RO_ATTR_ES_UI(first_error_ino, s_first_error_ino);
> +EXT4_RO_ATTR_ES_UI(last_error_ino, s_last_error_ino);
> +EXT4_RO_ATTR_ES_U64(first_error_block, s_first_error_block);
> +EXT4_RO_ATTR_ES_U64(last_error_block, s_last_error_block);
> +EXT4_RO_ATTR_ES_UI(first_error_line, s_first_error_line);
> +EXT4_RO_ATTR_ES_UI(last_error_line, s_last_error_line);
> +EXT4_RO_ATTR_ES_STRING(first_error_func, s_first_error_func, 32);
> +EXT4_RO_ATTR_ES_STRING(last_error_func, s_last_error_func, 32);
>  EXT4_ATTR(first_error_time, 0444, first_error_time);
>  EXT4_ATTR(last_error_time, 0444, last_error_time);
>  EXT4_ATTR(journal_task, 0444, journal_task);
> @@ -232,6 +266,16 @@ static struct attribute *ext4_attrs[] = {
>  	ATTR_LIST(msg_ratelimit_interval_ms),
>  	ATTR_LIST(msg_ratelimit_burst),
>  	ATTR_LIST(errors_count),
> +	ATTR_LIST(first_error_ino),
> +	ATTR_LIST(last_error_ino),
> +	ATTR_LIST(first_error_block),
> +	ATTR_LIST(last_error_block),
> +	ATTR_LIST(first_error_line),
> +	ATTR_LIST(last_error_line),
> +	ATTR_LIST(first_error_func),
> +	ATTR_LIST(last_error_func),
> +	ATTR_LIST(first_error_errcode),
> +	ATTR_LIST(last_error_errcode),
>  	ATTR_LIST(first_error_time),
>  	ATTR_LIST(last_error_time),
>  	ATTR_LIST(journal_task),
> @@ -290,7 +334,7 @@ static void *calc_ptr(struct ext4_attr *a, struct ext4_sb_info *sbi)
>  
>  static ssize_t __print_tstamp(char *buf, __le32 lo, __u8 hi)
>  {
> -	return snprintf(buf, PAGE_SIZE, "%lld",
> +	return snprintf(buf, PAGE_SIZE, "%lld\n",
>  			((time64_t)hi << 32) + le32_to_cpu(lo));
>  }
>  
> @@ -333,6 +377,25 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
>  			return 0;
>  		return snprintf(buf, PAGE_SIZE, "%lu\n",
>  				*((unsigned long *) ptr));
> +	case attr_pointer_u8:
> +		if (!ptr)
> +			return 0;
> +		return snprintf(buf, PAGE_SIZE, "%u\n",
> +				*((unsigned char *) ptr));
> +	case attr_pointer_u64:
> +		if (!ptr)
> +			return 0;
> +		if (a->attr_ptr == ptr_ext4_super_block_offset)
> +			return snprintf(buf, PAGE_SIZE, "%llu\n",
> +					le64_to_cpup(ptr));
> +		else
> +			return snprintf(buf, PAGE_SIZE, "%llu\n",
> +					*((unsigned long long *) ptr));
> +	case attr_pointer_string:
> +		if (!ptr)
> +			return 0;
> +		return snprintf(buf, PAGE_SIZE, "%.*s\n", a->attr_size,
> +				(char *) ptr);
>  	case attr_pointer_atomic:
>  		if (!ptr)
>  			return 0;
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
