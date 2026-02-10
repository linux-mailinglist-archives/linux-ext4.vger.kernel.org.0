Return-Path: <linux-ext4+bounces-13652-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAM5B4MUi2n5PQAAu9opvQ
	(envelope-from <linux-ext4+bounces-13652-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 12:20:35 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B89AF11A0EC
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 12:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2558C30333E5
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Feb 2026 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575C23191C0;
	Tue, 10 Feb 2026 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RTy0srup";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dS9wMZGd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RTy0srup";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dS9wMZGd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301EE30C60D
	for <linux-ext4@vger.kernel.org>; Tue, 10 Feb 2026 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722430; cv=none; b=WzLlH4eCLkDrSxrAA5N6zmdF2KhxLa69VZLuYVLJ0cgwMXDrSuKlJ8v8J1gkZ+cPvxttOTnEk9KpPirMQmk/wWHh4JtaXAGpyC3ZGKUvYo6ZfK77DfRcm86KDddF3sv+zTDU+mPw4BteS+feg7n1WFitTGv3FPJpcU9F2jhQrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722430; c=relaxed/simple;
	bh=zG31+GLCuJUKSSWbirrQTVdF3CjX6nr967D5y0EGiVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKkJknSH6bnY4Urrn2kHMIu119xA96TiUlgbOmZT8UKjL369XqtCCQubGIpbGswzCEqdnKh/3fg+iApBXORiK7yHbVLVNSSXgBFC0h8Ab1zjHx/9kEZtIM6P8/9RhPcyzKloXN0e9MwLtiS71wjAdbd28XnjcI5j8JxBLd3M7hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RTy0srup; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dS9wMZGd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RTy0srup; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dS9wMZGd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 670C95BD42;
	Tue, 10 Feb 2026 11:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770722426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Da7XXIYXHfG+QgXD+inIbI1Wk4GZnkh++DXrDctfaQ4=;
	b=RTy0srup7z57WM8QkTIVRCsSiXHaiWTdSBuQSBGASE7Ztap9QHC6b1ur1lKyLCENuq4a6W
	To6AUkRVo65L2lF02fESz9cdRIqCHU8PxrYDaDRi4/jU+N3k4z4F0l14lQyV6WZhcce7X2
	GuBQBAQ/PhQ2p1KxTRWXDiVyXKCLGzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770722426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Da7XXIYXHfG+QgXD+inIbI1Wk4GZnkh++DXrDctfaQ4=;
	b=dS9wMZGdMIJTAVTvo9KzbwOXEylIQ+OnflWWOVDVR4MyGfcn5E0DsRPolQ+bY3IOHq64Ah
	/BkQm8DeEsXFbsAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770722426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Da7XXIYXHfG+QgXD+inIbI1Wk4GZnkh++DXrDctfaQ4=;
	b=RTy0srup7z57WM8QkTIVRCsSiXHaiWTdSBuQSBGASE7Ztap9QHC6b1ur1lKyLCENuq4a6W
	To6AUkRVo65L2lF02fESz9cdRIqCHU8PxrYDaDRi4/jU+N3k4z4F0l14lQyV6WZhcce7X2
	GuBQBAQ/PhQ2p1KxTRWXDiVyXKCLGzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770722426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Da7XXIYXHfG+QgXD+inIbI1Wk4GZnkh++DXrDctfaQ4=;
	b=dS9wMZGdMIJTAVTvo9KzbwOXEylIQ+OnflWWOVDVR4MyGfcn5E0DsRPolQ+bY3IOHq64Ah
	/BkQm8DeEsXFbsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A8993EA62;
	Tue, 10 Feb 2026 11:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kw6xEXoUi2kqLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Feb 2026 11:20:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EB881A0A4E; Tue, 10 Feb 2026 12:20:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: fstests@vger.kernel.org
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/4] Avoid failing shutdown tests without a journal
Date: Tue, 10 Feb 2026 12:20:17 +0100
Message-ID: <20260210111707.17132-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.75
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13652-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B89AF11A0EC
X-Rspamd-Action: no action

Hello,

this patch series adds requirement for metadata journalling to couple
of tests using filesystem shutdown. After shutdown a filesystem without
a journal is not guaranteed to be consistent and thus tests often fail.

							Honza

