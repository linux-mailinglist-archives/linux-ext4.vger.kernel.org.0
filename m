Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A41BAFCA45
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2019 16:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfKNPwg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 10:52:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39806 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfKNPwg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Nov 2019 10:52:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEFnFp2158309;
        Thu, 14 Nov 2019 15:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=bYWwS1TvRdLAUQKeM5xESdEPYgo0jyUCgREe6gvlnOY=;
 b=LMv0MdSAuEVgnx8uLtIR/mtZo0vlywlFmplh5vlwICYg9hvpi5WfTWOmQPH9oyBOlJu2
 t9Sh46AA7M25TEvrVftQU5PWQs99EkXjiGG3DAe8q3nAWTVUWuZu57xh8aWcOPl5STmA
 b3iV9+XDgQ4CPlVdn6Cq9ukZ4brVcQckXO1Cb1NA4kVZbHRX1BiGhpLp//IiYpRFoqBE
 mCw7ShEdOT+EdLQGy+uzUPGmHkVmXQXZfJ6iv6w0WjUQVPo6kgOFGKEnyxL4lRPg4C6V
 P1j28OAOsoG9lQDE1UFKLXA0wvCjQiHxbcqZStjSZyn3+7jKr51zJTWY2Pqq8qcjNAR1 rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w5mvu44h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 15:52:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEFmD3e061813;
        Thu, 14 Nov 2019 15:52:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w8v2gukhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 15:52:28 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAEFqS6N024264;
        Thu, 14 Nov 2019 15:52:28 GMT
Received: from localhost (/10.159.137.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Nov 2019 07:52:28 -0800
Date:   Thu, 14 Nov 2019 07:52:27 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dmitry Monakhov <dmonakhov@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 2/2] ext4: Fix extent_status trace events
Message-ID: <20191114155227.GB6213@magnolia>
References: <20191114070330.14115-1-dmonakhov@gmail.com>
 <20191114070330.14115-3-dmonakhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114070330.14115-3-dmonakhov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911140144
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 14, 2019 at 07:03:30AM +0000, Dmitry Monakhov wrote:
>  - show pblock only if it has meaningful value
>  - Add missed EXTENT_STATUS_REFERENCED decoder
>  - Define status flags as explicit numbers instead of implicit enum ones
> 
> # before
>    ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [1/4294967294) 576460752303423487 0x8
>    ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [2/4294967293) 576460752303423487 0x18
>    ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [3/4294967292) 576460752303423487 0x18
>    ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [4/4294967291) 576460752303423487 0x18
> # after
>    ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [1/4294967294) 0 H
>    ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [2/4294967293) 0 HR
>    ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [3/4294967292) 0 HR
>    ext4:ext4_es_lookup_extent_exit: dev 253,0 ino 12 found 1 [4/4294967291) 0 HR
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
> ---
>  fs/ext4/extents_status.h    | 21 +++++++++++++--------
>  include/trace/events/ext4.h | 11 ++++++-----
>  2 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index 131a8b7..64b8fd1 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -30,14 +30,13 @@
>  /*
>   * These flags live in the high bits of extent_status.es_pblk
>   */
> -enum {
> -	ES_WRITTEN_B,
> -	ES_UNWRITTEN_B,
> -	ES_DELAYED_B,
> -	ES_HOLE_B,
> -	ES_REFERENCED_B,
> -	ES_FLAGS

Put:

TRACE_DEFINE_ENUM(ES_WRITTEN_B)
...
TRACE_DEFINE_ENUM(ES_FLAGS)

in include/trace/events/ext4.h and they should work properly.

We found this out the hard way in xfs land by stumbling across the
"documentation" in samples/trace_events/trace_events.h.

(I don't know if that same trick works for the BH flags in the previous
patch.)

--D

> -};
> +
> +#define ES_WRITTEN_B     0
> +#define ES_UNWRITTEN_B   1
> +#define ES_DELAYED_B     2
> +#define ES_HOLE_B        3
> +#define ES_REFERENCED_B  4
> +#define ES_FLAGS         5
>  
>  #define ES_SHIFT (sizeof(ext4_fsblk_t)*8 - ES_FLAGS)
>  #define ES_MASK (~((ext4_fsblk_t)0) << ES_SHIFT)
> @@ -208,6 +207,12 @@ static inline ext4_fsblk_t ext4_es_pblock(struct extent_status *es)
>  	return es->es_pblk & ~ES_MASK;
>  }
>  
> +static inline ext4_fsblk_t ext4_es_show_pblock(struct extent_status *es)
> +{
> +	ext4_fsblk_t pblock = ext4_es_pblock(es);
> +	return pblock == ~ES_MASK ? 0 : pblock;
> +}
> +
>  static inline void ext4_es_store_pblock(struct extent_status *es,
>  					ext4_fsblk_t pb)
>  {
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index d68e9e5..bdb5fc4 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -66,7 +66,8 @@ struct partial_cluster;
>  	{ EXTENT_STATUS_WRITTEN,	"W" },			\
>  	{ EXTENT_STATUS_UNWRITTEN,	"U" },			\
>  	{ EXTENT_STATUS_DELAYED,	"D" },			\
> -	{ EXTENT_STATUS_HOLE,		"H" })
> +	{ EXTENT_STATUS_HOLE,		"H" },			\
> +	{ EXTENT_STATUS_REFERENCED,	"R" })
>  
>  #define show_falloc_mode(mode) __print_flags(mode, "|",		\
>  	{ FALLOC_FL_KEEP_SIZE,		"KEEP_SIZE"},		\
> @@ -2262,7 +2263,7 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
>  		__entry->ino	= inode->i_ino;
>  		__entry->lblk	= es->es_lblk;
>  		__entry->len	= es->es_len;
> -		__entry->pblk	= ext4_es_pblock(es);
> +		__entry->pblk	= ext4_es_show_pblock(es);
>  		__entry->status	= ext4_es_status(es);
>  	),
>  
> @@ -2351,7 +2352,7 @@ TRACE_EVENT(ext4_es_find_extent_range_exit,
>  		__entry->ino	= inode->i_ino;
>  		__entry->lblk	= es->es_lblk;
>  		__entry->len	= es->es_len;
> -		__entry->pblk	= ext4_es_pblock(es);
> +		__entry->pblk	= ext4_es_show_pblock(es);
>  		__entry->status	= ext4_es_status(es);
>  	),
>  
> @@ -2405,7 +2406,7 @@ TRACE_EVENT(ext4_es_lookup_extent_exit,
>  		__entry->ino	= inode->i_ino;
>  		__entry->lblk	= es->es_lblk;
>  		__entry->len	= es->es_len;
> -		__entry->pblk	= ext4_es_pblock(es);
> +		__entry->pblk	= ext4_es_show_pblock(es);
>  		__entry->status	= ext4_es_status(es);
>  		__entry->found	= found;
>  	),
> @@ -2573,7 +2574,7 @@ TRACE_EVENT(ext4_es_insert_delayed_block,
>  		__entry->ino		= inode->i_ino;
>  		__entry->lblk		= es->es_lblk;
>  		__entry->len		= es->es_len;
> -		__entry->pblk		= ext4_es_pblock(es);
> +		__entry->pblk		= ext4_es_show_pblock(es);
>  		__entry->status		= ext4_es_status(es);
>  		__entry->allocated	= allocated;
>  	),
> -- 
> 2.7.4
> 
