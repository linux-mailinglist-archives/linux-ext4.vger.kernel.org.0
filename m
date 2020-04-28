Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE41BC3AE
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgD1P3R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 11:29:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49370 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgD1P3Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 11:29:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFHQGs141551;
        Tue, 28 Apr 2020 15:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5mAA3xC+nrArdoYtVbll3mhdB++GrMi2+gMu8YNFZ20=;
 b=HGdL/kUPuyAWBV/reWjijH8DkU3/IofNx6ZbdiCi0K2S/ARp5zLLyLLSBngwHrc8P/Yc
 k/86li73H8ZCRvTh23xEZcBoMpbS5Bp/odt+0tWwLzHeGBqSS4mVAkkXXLKtlQL08/Kb
 zuYWyoG/YrZksOjAu3W1r8Wkc6UPL50UjyrccNPVdgWBVvDl4UYWuX1NmxEYc1zh0vka
 rid8DlHMEG1PDzmu92/bM6lOUexNkV4mhUz7cyZ3QwsIaVMMoWINu9evw5/cIds7qC3W
 Bl/w0uZzMgRlFN3WZS/+HvcMo2rjojXC83dGRZj9zc7/dbgG03w0bN96TaYwGT5QUXL6 oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30p2p062vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:29:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFC2GX110942;
        Tue, 28 Apr 2020 15:27:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30mxrssp23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:27:12 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SFRBWQ025513;
        Tue, 28 Apr 2020 15:27:11 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:27:10 -0700
Date:   Tue, 28 Apr 2020 08:27:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     lczerner@redhat.com, viro@zeniv.linux.org.uk,
        linux-ext4@vger.kernel.org
Subject: Re: Notes on ext4 mount API parsing stuff
Message-ID: <20200428152709.GG6733@magnolia>
References: <1020558.1588082682@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1020558.1588082682@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280120
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 28, 2020 at 03:04:42PM +0100, David Howells wrote:
> Hi Lukas,
> 
> Here are some notes on your ext4 mount API parsing stuff.

Er... is this a response to Lukas' patchset "ext4: new mount API
conversion" from 6 Nov 2019?

--D

> >static int note_qf_name(struct fs_context *fc, int qtype,
> >		       struct fs_parameter *param)
> >{
> >...
> >	qname = kmemdup_nul(param->string, param->size, GFP_KERNEL);
> 
> No need to do this.  You're allowed to steal param->string.  Just NULL it out
> afterwards.  It's guaranteed to be NUL-terminated.
> 
> 	ctx->s_qf_names[qtype] = param->string;
> 	param->string = NULL;
> 
> >...
> >}
> > ...
> >static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >{
> >	struct ext4_fs_context *ctx = fc->fs_private;
> >	const struct mount_opts *m;
> >	struct fs_parse_result result;
> >	kuid_t uid;
> >	kgid_t gid;
> >	int token;
> >
> >	token = fs_parse(fc, ext4_param_specs, param, &result);
> >	if (token < 0)
> >		return token;
> >
> >#ifdef CONFIG_QUOTA
> >	if (token == Opt_usrjquota) {
> >		if (!*param->string)
> >			return unnote_qf_name(fc, USRQUOTA);
> >		else
> >			return note_qf_name(fc, USRQUOTA, param);
> >	} else if (token == Opt_grpjquota) {
> >		if (!*param->string)
> >			return unnote_qf_name(fc, GRPQUOTA);
> >		else
> >			return note_qf_name(fc, GRPQUOTA, param);
> >	}
> >#endif
> 
> Merge this into the switch-statement below?
> 
> >	switch (token) {
> >	case Opt_noacl:
> >	case Opt_nouser_xattr:
> >		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
> >		break;
> >	case Opt_removed:
> >		ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
> >			 param->key);
> >		return 0;
> >	case Opt_abort:
> >		set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
> >		return 0;
> >	case Opt_i_version:
> >		set_flags(ctx, SB_I_VERSION);
> >		return 0;
> >	case Opt_lazytime:
> >		set_flags(ctx, SB_LAZYTIME);
> >		return 0;
> >	case Opt_nolazytime:
> >		clear_flags(ctx, SB_LAZYTIME);
> >		return 0;
> >	case Opt_errors:
> >	case Opt_data:
> >	case Opt_data_err:
> >	case Opt_jqfmt:
> >		token = result.uint_32;
> >	}
> 
> Missing break directive?
> 
> >	for (m = ext4_mount_opts; m->token != Opt_err; m++)
> >		if (token == m->token)
> >			break;
> 
> I guess this can't be turned into a direct array lookup given what else
> ext4_mount_opts[] is used for.
> 
> >	ctx->opt_flags |= m->flags;
> >
> >	if (m->token == Opt_err) {
> >		ext4_msg(NULL, KERN_ERR, "Unrecognized mount option \"%s\" "
> >			 "or missing value", param->key);
> >		return -EINVAL;
> >	}
> >
> >	if (m->flags & MOPT_EXPLICIT) {
> >		if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
> >			set_mount_opt2(ctx, EXT4_MOUNT2_EXPLICIT_DELALLOC);
> >		} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
> >			set_mount_opt2(ctx,
> >				       EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM);
> >		} else
> >			return -EINVAL;
> >	}
> >	if (m->flags & MOPT_CLEAR_ERR)
> >		clear_mount_opt(ctx, EXT4_MOUNT_ERRORS_MASK);
> >
> >	if (m->flags & MOPT_NOSUPPORT) {
> >		ext4_msg(NULL, KERN_ERR, "%s option not supported",
> >			 param->key);
> >	} else if (token == Opt_commit) {
> >		if (result.uint_32 == 0)
> >			ctx->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE;
> >		else if (result.uint_32 > INT_MAX / HZ) {
> >			ext4_msg(NULL, KERN_ERR,
> >				 "Invalid commit interval %d, "
> >				 "must be smaller than %d",
> >				 result.uint_32, INT_MAX / HZ);
> >			return -EINVAL;
> 
> You're doing this a lot.  It might be worth making a macro something like:
> 
> #define ext4_inval(fmt, ...) \
> 	({ ext4_msg(NULL, KERN_ERR, ## __VA_LIST__), -EINVAL })
> 
> then you can just do:
> 
> 	return ext4_inval("Invalid commit interval %d, must be smaller than %d",
> 			  result.uint_32, INT_MAX / HZ);
> 
> >		}
> >		ctx->s_commit_interval = HZ * result.uint_32;
> >		ctx->spec |= EXT4_SPEC_s_commit_interval;
> >	} else if (token == Opt_debug_want_extra_isize) {
> 
> This whole thing looks like it might be better as a switch-statement.
> 
> >	}
> >	return 0;
> >}
> >
> >static int parse_options(struct fs_context *fc, char *options)
> >{
> >}
> 
> I wonder if this could be replaced with a call to generic_parse_monolithic() -
> though that calls security_sb_eat_lsm_opts() which you might not want.
> 
> David
> 
