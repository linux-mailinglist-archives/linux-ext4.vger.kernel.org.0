Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11821BC087
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgD1OEu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 10:04:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42149 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727933AbgD1OEu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 10:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588082688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4zvqBCg098ovR8dFjmTUuCU9Nkp7zOhIutaHG4wiHTc=;
        b=V4pYBcZAJOPSWDV6hUGNw4n6TnlIskTCjNfkXzHtmiCmOkz1Zt3KvsTSy895o0zO/53/VF
        WpB3Fo1ZiysPwnlxu/u1dfY0YifoEUogs9QAFYYAjZnzxeWP+WbNrJjjkW50iAInQ/wRad
        ag96L0yhncEosoYvROineLWze3a+1lA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-jJvNShcYOhG0_Q-JhooAFg-1; Tue, 28 Apr 2020 10:04:44 -0400
X-MC-Unique: jJvNShcYOhG0_Q-JhooAFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDACD800685;
        Tue, 28 Apr 2020 14:04:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6B995D715;
        Tue, 28 Apr 2020 14:04:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     lczerner@redhat.com
cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-ext4@vger.kernel.org
Subject: Notes on ext4 mount API parsing stuff
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1020557.1588082682.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 28 Apr 2020 15:04:42 +0100
Message-ID: <1020558.1588082682@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Lukas,

Here are some notes on your ext4 mount API parsing stuff.

>static int note_qf_name(struct fs_context *fc, int qtype,
>		       struct fs_parameter *param)
>{
>...
>	qname =3D kmemdup_nul(param->string, param->size, GFP_KERNEL);

No need to do this.  You're allowed to steal param->string.  Just NULL it =
out
afterwards.  It's guaranteed to be NUL-terminated.

	ctx->s_qf_names[qtype] =3D param->string;
	param->string =3D NULL;

>...
>}
> ...
>static int ext4_parse_param(struct fs_context *fc, struct fs_parameter *p=
aram)
>{
>	struct ext4_fs_context *ctx =3D fc->fs_private;
>	const struct mount_opts *m;
>	struct fs_parse_result result;
>	kuid_t uid;
>	kgid_t gid;
>	int token;
>
>	token =3D fs_parse(fc, ext4_param_specs, param, &result);
>	if (token < 0)
>		return token;
>
>#ifdef CONFIG_QUOTA
>	if (token =3D=3D Opt_usrjquota) {
>		if (!*param->string)
>			return unnote_qf_name(fc, USRQUOTA);
>		else
>			return note_qf_name(fc, USRQUOTA, param);
>	} else if (token =3D=3D Opt_grpjquota) {
>		if (!*param->string)
>			return unnote_qf_name(fc, GRPQUOTA);
>		else
>			return note_qf_name(fc, GRPQUOTA, param);
>	}
>#endif

Merge this into the switch-statement below?

>	switch (token) {
>	case Opt_noacl:
>	case Opt_nouser_xattr:
>		ext4_msg(NULL, KERN_WARNING, deprecated_msg, param->key, "3.5");
>		break;
>	case Opt_removed:
>		ext4_msg(NULL, KERN_WARNING, "Ignoring removed %s option",
>			 param->key);
>		return 0;
>	case Opt_abort:
>		set_mount_flags(ctx, EXT4_MF_FS_ABORTED);
>		return 0;
>	case Opt_i_version:
>		set_flags(ctx, SB_I_VERSION);
>		return 0;
>	case Opt_lazytime:
>		set_flags(ctx, SB_LAZYTIME);
>		return 0;
>	case Opt_nolazytime:
>		clear_flags(ctx, SB_LAZYTIME);
>		return 0;
>	case Opt_errors:
>	case Opt_data:
>	case Opt_data_err:
>	case Opt_jqfmt:
>		token =3D result.uint_32;
>	}

Missing break directive?

>	for (m =3D ext4_mount_opts; m->token !=3D Opt_err; m++)
>		if (token =3D=3D m->token)
>			break;

I guess this can't be turned into a direct array lookup given what else
ext4_mount_opts[] is used for.

>	ctx->opt_flags |=3D m->flags;
>
>	if (m->token =3D=3D Opt_err) {
>		ext4_msg(NULL, KERN_ERR, "Unrecognized mount option \"%s\" "
>			 "or missing value", param->key);
>		return -EINVAL;
>	}
>
>	if (m->flags & MOPT_EXPLICIT) {
>		if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
>			set_mount_opt2(ctx, EXT4_MOUNT2_EXPLICIT_DELALLOC);
>		} else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
>			set_mount_opt2(ctx,
>				       EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM);
>		} else
>			return -EINVAL;
>	}
>	if (m->flags & MOPT_CLEAR_ERR)
>		clear_mount_opt(ctx, EXT4_MOUNT_ERRORS_MASK);
>
>	if (m->flags & MOPT_NOSUPPORT) {
>		ext4_msg(NULL, KERN_ERR, "%s option not supported",
>			 param->key);
>	} else if (token =3D=3D Opt_commit) {
>		if (result.uint_32 =3D=3D 0)
>			ctx->s_commit_interval =3D JBD2_DEFAULT_MAX_COMMIT_AGE;
>		else if (result.uint_32 > INT_MAX / HZ) {
>			ext4_msg(NULL, KERN_ERR,
>				 "Invalid commit interval %d, "
>				 "must be smaller than %d",
>				 result.uint_32, INT_MAX / HZ);
>			return -EINVAL;

You're doing this a lot.  It might be worth making a macro something like:

#define ext4_inval(fmt, ...) \
	({ ext4_msg(NULL, KERN_ERR, ## __VA_LIST__), -EINVAL })

then you can just do:

	return ext4_inval("Invalid commit interval %d, must be smaller than %d",
			  result.uint_32, INT_MAX / HZ);

>		}
>		ctx->s_commit_interval =3D HZ * result.uint_32;
>		ctx->spec |=3D EXT4_SPEC_s_commit_interval;
>	} else if (token =3D=3D Opt_debug_want_extra_isize) {

This whole thing looks like it might be better as a switch-statement.

>	}
>	return 0;
>}
>
>static int parse_options(struct fs_context *fc, char *options)
>{
>}

I wonder if this could be replaced with a call to generic_parse_monolithic=
() -
though that calls security_sb_eat_lsm_opts() which you might not want.

David

