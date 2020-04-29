Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5DF1BDA6E
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 13:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD2LPM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 07:15:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44379 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2LPM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Apr 2020 07:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588158910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ML4rKbtGgsi0JjgxUp2Z9HVs9hh0/DgFuxbZ1atkKoU=;
        b=J8Rw+AvWyCKwP0iN9yfHXbAC6G74+gzP+7KiwR8VpiH82BfWFrj2ZyRJclQTfAscEEYY14
        uM2OWvl+khm5ymyp77f8JadUaq7KTH14Ys2lJFFbuS9QdU4OHBmZclfvnY4wliRoGOjnsZ
        NnFE/7IhfBGf+AtIWljn2PAa0adzfJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-FTW_Wj1-My6pHtfFV76D6Q-1; Wed, 29 Apr 2020 07:15:08 -0400
X-MC-Unique: FTW_Wj1-My6pHtfFV76D6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90704EC1C4;
        Wed, 29 Apr 2020 11:15:07 +0000 (UTC)
Received: from work (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 994A366070;
        Wed, 29 Apr 2020 11:15:04 +0000 (UTC)
Date:   Wed, 29 Apr 2020 13:15:01 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-ext4@vger.kernel.org
Subject: Re: Notes on ext4 mount API parsing stuff
Message-ID: <20200429111501.lsshz3cd4lvur3gh@work>
References: <1020558.1588082682@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1020558.1588082682@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 28, 2020 at 03:04:42PM +0100, David Howells wrote:
> Hi Lukas,
> 
> Here are some notes on your ext4 mount API parsing stuff.
> 
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

Good to know, I'll do that.

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

Yes, I'd like to. But I am trying to avoid cleanup changes that are not
necessarily needed for the API conversion. So yes, I will do this, but
with a separate series, there is a lot more to clean up as well.

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

yep, thanks.

> 
> >	for (m = ext4_mount_opts; m->token != Opt_err; m++)
> >		if (token == m->token)
> >			break;
> 
> I guess this can't be turned into a direct array lookup given what else
> ext4_mount_opts[] is used for.

Yes, unfortunatelly. But I'd like to change that in the cleanup series
after the conversion.

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

Yeah, it might be worth doing. Thanks.

> 
> >		}
> >		ctx->s_commit_interval = HZ * result.uint_32;
> >		ctx->spec |= EXT4_SPEC_s_commit_interval;
> >	} else if (token == Opt_debug_want_extra_isize) {
> 
> This whole thing looks like it might be better as a switch-statement.

Indeed, but again not as a part of api conversion.

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

This is eventually only used to parse mount options in super block, so
we do not want to call security_sb_eat_lsm_opts(). Other than that it's
basically exactly what generic_parse_monolithic() does.

Thanks!
-Lukas

> 
> David
> 

