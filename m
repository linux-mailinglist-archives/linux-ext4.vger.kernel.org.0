Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1D94DC9E
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 23:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfFTVfA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 17:35:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41874 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfFTVfA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jun 2019 17:35:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KLYHC0097277;
        Thu, 20 Jun 2019 21:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=8/hP1gZbSChvwo7mSZDi/irfCoSiD/XJYR7/7zJjjjM=;
 b=egULdwdm2jA4bh3r3Zs9OELL0UW7onVVnPL6kcKK5HYWKILolxg8UeoozktxnWbtNyho
 VZjV4tZVtgZdfgpbAA3ydMBu/29u0JFPt6BeppdLibQuw2QMod61BxT+N+FSoM83rz/m
 29LpRONzW55S2L/gvkz3jSpiPw0NFiCJiXoui4FhTf5AbYyKi4qAznKkzkipu7hmD6vS
 d5xzyKxtLU9YmHMnH1rG3hHfLPLVs42+Ils6mxUs87RZK6WxbtJo8bVXcXSUoP1rcB4F
 cErCXjnRvei+YBEKjJrDJSPWjveWgpYcSYgIj636y07DS5W8jpw8USEvq75znDKTgMph OQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t7809kcav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:34:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KLYlTQ145879;
        Thu, 20 Jun 2019 21:34:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t77ypkqwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:34:55 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5KLYtBE001306;
        Thu, 20 Jun 2019 21:34:55 GMT
Received: from localhost (/10.145.179.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 14:34:55 -0700
Date:   Thu, 20 Jun 2019 14:34:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] jbd2: drop declaration of journal_sync_buffer()
Message-ID: <20190620213454.GA5375@magnolia>
References: <20190620213228.8191-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620213228.8191-1-tytso@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200154
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 20, 2019 at 05:32:28PM -0400, Theodore Ts'o wrote:
> The journal_sync_buffer() function was never carried over from jbd to
> jbd2.  So get rid of the vestigal declaration of this (non-existent)
> function.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/jbd2/journal.c    | 3 ---
>  include/linux/jbd2.h | 1 -
>  2 files changed, 4 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 17f679aeba7c..953990eb70a9 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -66,9 +66,6 @@ EXPORT_SYMBOL(jbd2_journal_get_undo_access);
>  EXPORT_SYMBOL(jbd2_journal_set_triggers);
>  EXPORT_SYMBOL(jbd2_journal_dirty_metadata);
>  EXPORT_SYMBOL(jbd2_journal_forget);
> -#if 0
> -EXPORT_SYMBOL(journal_sync_buffer);
> -#endif
>  EXPORT_SYMBOL(jbd2_journal_flush);
>  EXPORT_SYMBOL(jbd2_journal_revoke);
>  
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 0e0393e7f41a..df03825ad1a1 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1373,7 +1373,6 @@ void		 jbd2_journal_set_triggers(struct buffer_head *,
>  					   struct jbd2_buffer_trigger_type *type);
>  extern int	 jbd2_journal_dirty_metadata (handle_t *, struct buffer_head *);
>  extern int	 jbd2_journal_forget (handle_t *, struct buffer_head *);
> -extern void	 journal_sync_buffer (struct buffer_head *);
>  extern int	 jbd2_journal_invalidatepage(journal_t *,
>  				struct page *, unsigned int, unsigned int);
>  extern int	 jbd2_journal_try_to_free_buffers(journal_t *, struct page *, gfp_t);
> -- 
> 2.22.0
> 
