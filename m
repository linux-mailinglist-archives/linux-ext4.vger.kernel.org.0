Return-Path: <linux-ext4+bounces-1352-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E6785E56A
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 19:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B512B21D9F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB485272;
	Wed, 21 Feb 2024 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vaj9bjbF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PvnPjN/6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vaj9bjbF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PvnPjN/6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583C84FA5
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539658; cv=none; b=raIMWMs4Xns9dBK0hbzx58n3RPZM5zH2Mj9DLYCHLXF1+VgAGzJfwUv4ctG+zdt6UZMhIgwOsy+53S+les6wkJwEgh96T7vbeN4f2yGx2rckgl7GY6CKE68zCFhhN9ONAUBork5ywqqnGiRqITDyrfQkRAmuBj/HeSHxof/PEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539658; c=relaxed/simple;
	bh=uYmLucUZjz0oG8EuH8T/hqYgaM0eG9dlBgFGWNFzHk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V4msEWHBT3ZulyhEodq3lBGlXE+KK0Gr9qyom3/Xk/94UaiVv4BJz5sjlQ5rmWv6OBBlkByaYoLvxKABHoKxkvKLowBuVDJzeOS2uhzG7udZYA5jrbTN1/IwLorbz+wMRZ0hbwRBSLYrf0eJREWl83dwQHbZ58v1bI++OIBQ7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vaj9bjbF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PvnPjN/6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vaj9bjbF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PvnPjN/6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CFC5A1F831;
	Wed, 21 Feb 2024 18:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708539654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mFEKpRet8Zl7lbJAcM3uFw9uObfTgGdoQrbnAzpKcG4=;
	b=Vaj9bjbFTFyAO3M5V0hm22l9zpTYQDWu8wICe2pqmzENxV2JCk/jVtti96GJX2wgc9tzUp
	E0U2NMAVnmhLsRtOj2pqfvC+SspgS01rpr0tnWNH401J4K2VtQdp5ewjxJaP/BrjD6O7QI
	MNLsm2ay+D5galtjh+LcS3JQpI5T2j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708539654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mFEKpRet8Zl7lbJAcM3uFw9uObfTgGdoQrbnAzpKcG4=;
	b=PvnPjN/6c8nbnVBNE4UV1u9+gtMVUTxcXcoC1/xlLEAvHGgDiVsWPbkIhmF2FmM16PAMOs
	Zx4buRm5jhR6x3AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708539654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mFEKpRet8Zl7lbJAcM3uFw9uObfTgGdoQrbnAzpKcG4=;
	b=Vaj9bjbFTFyAO3M5V0hm22l9zpTYQDWu8wICe2pqmzENxV2JCk/jVtti96GJX2wgc9tzUp
	E0U2NMAVnmhLsRtOj2pqfvC+SspgS01rpr0tnWNH401J4K2VtQdp5ewjxJaP/BrjD6O7QI
	MNLsm2ay+D5galtjh+LcS3JQpI5T2j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708539654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mFEKpRet8Zl7lbJAcM3uFw9uObfTgGdoQrbnAzpKcG4=;
	b=PvnPjN/6c8nbnVBNE4UV1u9+gtMVUTxcXcoC1/xlLEAvHGgDiVsWPbkIhmF2FmM16PAMOs
	Zx4buRm5jhR6x3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84F7613A69;
	Wed, 21 Feb 2024 18:20:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fmSVHAY/1mW0OQAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Wed, 21 Feb 2024 18:20:54 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id e622371e;
	Wed, 21 Feb 2024 18:20:49 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: linux-ext4@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: fstest generic/696 failure on ext4 fs with quotas+idmap
Date: Wed, 21 Feb 2024 18:20:49 +0000
Message-ID: <87jzmxisqm.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.11 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.01)[49.79%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.11

Hi!

The fstest generic/696 (and 697) fail on ext4 when the filesystem is
created with quota support (-O quota).  It's really easy to reproduce, and
it fails when doing the idmapped tests (setgid_create_umask_idmapped() and
setgid_create_umask_idmapped_in_userns()).

The failure happens when the test does an openat() with O_TMPFILE:

  ext4_tmpfile()
    __ext4_new_inode()
      dquot_initialize()
        dqget()

and at this point the error occurs:

	if (!qid_has_mapping(sb->s_user_ns, qid))
		return ERR_PTR(-EINVAL);

qid is '-1', which is invalid, but I'm failing to understand if it should
really be invalid or if dqget() should handle this invalid qid some other
way.  Earlier, __ext4_new_inode() called inode_init_owner(), which indeed
sets inode->i_uid with '-1'.

I've been trying to figure it out, but it's very tricky to follow all the
details, so I decided to ask here and see if anyone has any idea.  Is this
a known issue?  Maybe the issue is with the test itself, and not with
ext4, quota or idmapped code.

Cheers,
--=20
Lu=C3=ADs

