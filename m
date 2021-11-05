Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDAE446190
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Nov 2021 10:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhKEJwg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Nov 2021 05:52:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50808 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhKEJwg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Nov 2021 05:52:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 219EC1FD36;
        Fri,  5 Nov 2021 09:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636105796;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RRWMMk17DEUJ38plRlKGaMqVFwoarVGmkRNCrKvlLlE=;
        b=EHIGftrMPkFRrjr+SuZB9O8gmgYFpzR0uil99nJMC6+7+SUAOshCPnFZQK7DndFf6mfnru
        n9jElJVP1FFj/bdxXKGGHyVsbutZh3ynaVBF2ZjsEx69Ct/nZ1azumbQbGq1pOIpzomet3
        l9x3UKBzrRBaCWVEoMVbXHF3IoGoxQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636105796;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RRWMMk17DEUJ38plRlKGaMqVFwoarVGmkRNCrKvlLlE=;
        b=BaNhKzDqtgydvv/EjFreSV71xfA0X0pxAeTvO9F0SvNqZiOP49yuS8M9fNDpI+tht+NaNt
        bakhs2yq8LSa7HBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0B5413B97;
        Fri,  5 Nov 2021 09:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2UjXLEP+hGHtcAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 09:49:55 +0000
Date:   Fri, 5 Nov 2021 10:49:54 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, repnop@google.com,
        linux-ext4@vger.kernel.org, kernel@collabora.com,
        khazhy@google.com, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v3 5/9] syscalls/fanotify21: Validate incoming FID
 in FAN_FS_ERROR
Message-ID: <YYT+Qm/Sy3drGR1+@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029211732.386127-6-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
> +				 const struct test_case *ex)
> +{
> +	struct file_handle *fh = (struct file_handle *) &fid->handle;
> +
> +	if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
> +		tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
> +			ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
> +			FSID_VAL_MEMBER(ex->fid->fsid, 0));
Correct way is (I'll fix it before pushing this PR):

	if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
		tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
			ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
			ex->fid->fsid.val[0]);

Using FSID_VAL_MEMBER() is invalid, it broke compilation for musl.
FSID_VAL_MEMBER was created to fix musl compilations, but it should be used only
for struct fanotify_event_info_fid, using it for struct event_t (which has also
__kernel_fsid_t fsid) is invalid and causes this error:

In file included from fanotify21.c:35:
fanotify21.c: In function 'check_error_event_info_fid':
fanotify.h:200:41: error: 'lapi_fsid_t' has no member named '__val'; did you mean 'val'?
  200 | # define FSID_VAL_MEMBER(fsid, i) (fsid.__val[i])
      |                                         ^~~~~
../../../../include/tst_test.h:58:54: note: in expansion of macro 'FSID_VAL_MEMBER'
   58 |   tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
      |                                                      ^~~~~~~~~~~
fanotify21.c:132:3: note: in expansion of macro 'tst_res'
  132 |   tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
      |   ^~~~~~~
make: *** [../../../../include/mk/rules.mk:37: fanotify21] Error 1

Sorry for confusion, not sure how to improve FSID_VAL_MEMBER() to avoid these
errors.

See f37704d6c ("fanotify: Fix FSID_VAL_MEMBER() usage")

Kind regards,
Petr
