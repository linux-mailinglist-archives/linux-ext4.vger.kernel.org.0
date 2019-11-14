Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00DB1FD003
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2019 22:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKNVB0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 16:01:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47802 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfKNVB0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Nov 2019 16:01:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEKxDxW037473;
        Thu, 14 Nov 2019 21:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=FCV7jGzZ+vno0d71lnt+UQX9hacIcuLMG5VEsrhOWkI=;
 b=fm1qQ7ljacoCBS+sd+WLabtpI0JxqoDX5usgIgXMV0mvhNjaBMCcOr3OORCZxsyrX6ah
 JD4CB/UfG5lDNy97Wa6rCkpyUhHJdSa7qNbu6Z3/05tFCtnblIjj/myXPWpAyHk/WDzH
 oUaG/oTrxAHXLjfSR5/E+2jqY8gubS7KdCTUaJKA8EQuPjLnszskrmsDzsLcsao+Or7t
 OX9xzKh+zrEKBbsvy1NqOOgI3JYVP7Frfw353SmD15o583pEH905udEEeYh0IP1oVn3X
 KpO5pteVj5J3RlNlhNkSJeVd50pNWObZG6RCaR+yhLhI0hwHmca5p1mzjBo7CW5iNsj3 Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w5mvu5tge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 21:01:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAEKsGSs001810;
        Thu, 14 Nov 2019 21:01:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w8g1a1tgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 21:01:20 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAEL1JD9009162;
        Thu, 14 Nov 2019 21:01:19 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Nov 2019 13:01:19 -0800
Date:   Thu, 14 Nov 2019 13:01:17 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dmitry Monakhov <dmonakhov@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 1/2] ext4: fix symbolic enum printing in trace output
Message-ID: <20191114210117.GC6213@magnolia>
References: <20191114200147.1073-1-dmonakhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114200147.1073-1-dmonakhov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911140174
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 14, 2019 at 08:01:46PM +0000, Dmitry Monakhov wrote:
> Trace's macro __print_flags() produce raw event's decraration w/o knowing actual
> flags value
> 
> cat /sys/kernel/debug/tracing/events/ext4/ext4_ext_map_blocks_exit/format
> ..
> __print_flags(REC->mflags, "", { (1 << BH_New),
> 
> For that reason we have to explicitly define it via special macro TRACE_DEFINE_ENUM()
> Also add missed EXTENT_STATUS_REFERENCED flag.
> 
> #Before patch
> ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 2 flags  lblk 0 pblk 4177 len 1 mflags 0x20 ret 1
> ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 12 flags CREATE lblk 0 pblk 34304 len 1 mflags 0x60 ret 1
> 
> #With patch
> ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 2 flags  lblk 0 pblk 4177 len 1 mflags M ret 1
> ext4:ext4_ext_map_blocks_exit: dev 253,0 ino 12 flags CREATE lblk 0 pblk 34816 len 1 mflags NM ret 1
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
> ---
>  include/trace/events/ext4.h | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 182c9fe..3bf7128 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -48,6 +48,16 @@ struct partial_cluster;
>  	{ EXT4_GET_BLOCKS_KEEP_SIZE,		"KEEP_SIZE" },		\
>  	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" })
>  
> +/*
> + * __print_flags() requires that all enum values be wrapped in the
> + * TRACE_DEFINE_ENUM macro so that the enum value can be encoded in the ftrace
> + * ring buffer.
> + */
> +TRACE_DEFINE_ENUM(BH_New);
> +TRACE_DEFINE_ENUM(BH_Mapped);
> +TRACE_DEFINE_ENUM(BH_Unwritten);
> +TRACE_DEFINE_ENUM(BH_Boundary);
> +
>  #define show_mflags(flags) __print_flags(flags, "",	\
>  	{ EXT4_MAP_NEW,		"N" },			\
>  	{ EXT4_MAP_MAPPED,	"M" },			\
> @@ -62,11 +72,18 @@ struct partial_cluster;
>  	{ EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER,"1ST_CLUSTER" },\
>  	{ EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER,	"LAST_CLUSTER" })
>  
> +TRACE_DEFINE_ENUM(ES_WRITTEN_B);
> +TRACE_DEFINE_ENUM(ES_UNWRITTEN_B);
> +TRACE_DEFINE_ENUM(ES_DELAYED_B);
> +TRACE_DEFINE_ENUM(ES_HOLE_B);
> +TRACE_DEFINE_ENUM(ES_REFERENCED_B);

I wonder if it's worth leaving a comment wherever this enum is defined
warning developers to keep this TRACE_DEFINE_NUM list (and the string
mapping) up to date?

--D

>  #define show_extent_status(status) __print_flags(status, "",	\
>  	{ EXTENT_STATUS_WRITTEN,	"W" },			\
>  	{ EXTENT_STATUS_UNWRITTEN,	"U" },			\
>  	{ EXTENT_STATUS_DELAYED,	"D" },			\
> -	{ EXTENT_STATUS_HOLE,		"H" })
> +	{ EXTENT_STATUS_HOLE,		"H" },			\
> +	{ EXTENT_STATUS_REFERENCED,	"R" })
>  
>  #define show_falloc_mode(mode) __print_flags(mode, "|",		\
>  	{ FALLOC_FL_KEEP_SIZE,		"KEEP_SIZE"},		\
> -- 
> 2.7.4
> 
