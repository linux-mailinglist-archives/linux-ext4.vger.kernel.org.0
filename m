Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20CF3F369C
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Aug 2021 00:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhHTWpk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 18:45:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56356 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229451AbhHTWpj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 18:45:39 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17KMiv1E013803
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 18:44:57 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0139115C3DBB; Fri, 20 Aug 2021 18:44:56 -0400 (EDT)
Date:   Fri, 20 Aug 2021 18:44:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] tune2fs: Fix conversion of quota files
Message-ID: <YSAwaKONl7vptrX/@mit.edu>
References: <20210820194656.27799-1-jack@suse.cz>
 <20210820194656.27799-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820194656.27799-3-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 20, 2021 at 09:46:56PM +0200, Jan Kara wrote:
> 
> diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
> index fbc3833aee98..34ab632fb81c 100644
> --- a/lib/support/mkquota.c
> +++ b/lib/support/mkquota.c
> @@ -569,14 +569,14 @@ static int scan_dquots_callback(struct dquot *dquot, void *cb_data)
>   */
>  static errcode_t quota_read_all_dquots(struct quota_handle *qh,
>                                         quota_ctx_t qctx,
> -				       int update_limits EXT2FS_ATTR((unused)))
> +				       int update_limits)
>  {
>  	struct scan_dquots_data scan_data;
>  
>  	scan_data.quota_dict = qctx->quota_dict[qh->qh_type];
>  	scan_data.check_consistency = 0;
> -	scan_data.update_limits = 0;
> -	scan_data.update_usage = 1;
> +	scan_data.update_limits = update_limits;
> +	scan_data.update_usage = 0;
>  
>  	return qh->qh_ops->scan_dquots(qh, scan_dquots_callback, &scan_data);
>  }

This change, while it is correct for tune2fs, is breaking e2fsck's
f_orphquot test.  The root cause is that e2fsck_read_all_quotas() in
e2fsck/super.c is calling quota_update_limits(), where it had wanted
to be reading the quota usage data, not the limits.

I think what we need to do is to take quota_read_all_dquots(), which
is only used by quota_update_limits(), and then fodl it into
quota_update_limits().  And then add a flags parameter to indicate
whether we want to be reading the limits or the usage, and then rename
quota_update_limits() to quota_read_all_dquots().

Does that make sense to you?  (One of the reasons why the quota
functions are all in libsupport is precisely because I knew these
functions still needed more polishing.)

						- Ted
