Return-Path: <linux-ext4+bounces-1725-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC097885D64
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 17:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676D6281935
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Mar 2024 16:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464012CDB0;
	Thu, 21 Mar 2024 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSizIXzm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ojW+2UB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hSizIXzm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ojW+2UB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3932D12CD94
	for <linux-ext4@vger.kernel.org>; Thu, 21 Mar 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038421; cv=none; b=iDZdU5YUMbtx4jcnWywa6rjH73u5aPG+y6khJzipq0wWrBsnUftZX8EW/KlFYfmbVjbzG0r4ArVD+QcwFdW6jq1WKqw1cgBjNdfENfxgc3n9vHz4vgRJeHHLiVBsjfctyWl4juEotGYt39M650ZNAxegFfm2uGeCoEuz3D0Feh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038421; c=relaxed/simple;
	bh=7L9SP9O+mfsUouGNn+D3HTbei5yly9HNa0mCNqxEMKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kJ0iqWg8CdfnPMc3dCPwfi+QFRcKaxZ0Jenfq2i6wRJF5xsIot+Z1+73qjIHY9ymCP5leODPrFH3KPvHfL+TYeD56xn2N0AUX2ZAfs0yF86yeh5+1GwudXHH//bHpoC1oY4dwG+i+X++x8ofPjbyH3T3vXUHlVZ3jHn2uJZzNrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSizIXzm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ojW+2UB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hSizIXzm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ojW+2UB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4880137680;
	Thu, 21 Mar 2024 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711038418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vRwerLhKIJt3Jh5ZEKLi7v+ECp+KFOHkQvqJndnRn94=;
	b=hSizIXzm/LSy5oC+zfZiuetHW7Ckj55nkgK5c1vtwb2n1DxU31MqsvZkLSEe8g5k+KTLdT
	wJgqLlSkT7L9y9st9Ou48d/lwESkHR8VLdDEU75ktNA1dpB7R3nQeE6SE+XrpdOHCPRd/u
	h+t3J5S5mFQKIcneEBl7OfxSbGgHgeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711038418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vRwerLhKIJt3Jh5ZEKLi7v+ECp+KFOHkQvqJndnRn94=;
	b=0ojW+2UBAtiaKjntQQy0fqhRXrk9TW4rT94yx1fqbxxL9HoFewO8jDOXvdPYNqbZ5Jg3rV
	7fLwEoyDE3gH22BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711038418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vRwerLhKIJt3Jh5ZEKLi7v+ECp+KFOHkQvqJndnRn94=;
	b=hSizIXzm/LSy5oC+zfZiuetHW7Ckj55nkgK5c1vtwb2n1DxU31MqsvZkLSEe8g5k+KTLdT
	wJgqLlSkT7L9y9st9Ou48d/lwESkHR8VLdDEU75ktNA1dpB7R3nQeE6SE+XrpdOHCPRd/u
	h+t3J5S5mFQKIcneEBl7OfxSbGgHgeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711038418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vRwerLhKIJt3Jh5ZEKLi7v+ECp+KFOHkQvqJndnRn94=;
	b=0ojW+2UBAtiaKjntQQy0fqhRXrk9TW4rT94yx1fqbxxL9HoFewO8jDOXvdPYNqbZ5Jg3rV
	7fLwEoyDE3gH22BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37FD613929;
	Thu, 21 Mar 2024 16:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RPmnDdJf/GW3GQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Mar 2024 16:26:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C2975A07D6; Thu, 21 Mar 2024 17:26:57 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v2] ext4: Create EA inodes outside of buffer lock
Date: Thu, 21 Mar 2024 17:26:48 +0100
Message-Id: <20240209111418.22308-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=jack@suse.cz; h=from:subject:message-id; bh=7L9SP9O+mfsUouGNn+D3HTbei5yly9HNa0mCNqxEMKo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBl/F/BJcmzY1Ro44mm1hft364eMrLnFyYVYgKjTUnF 9HIhQjaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZfxfwQAKCRCcnaoHP2RA2egtB/ 4pf4CiWk5vtfxHebMHAPzljxbGpjPQ3TUsbnYUqHz/Px/UMpUwcBK8iSMWn37JhGmOzq8Uk5QnoiXH d4ZPrs+itXjWU+wntx+TzBppn1XF8bEiJNgAsnB9zX6x0ifNZh7+APqp8L9z2o2QhhljTmOsYo6pdA qxlsyUBFkE9+brUd7cy3bPTe+bdledidy/KdsrFDWyaQEMhJeL4MyRZZ/AuGv03w6PPTrTAKw/DYhJ +FHWAgKVdRA6iWSsFx33yBAgR+iXISXAdTv8dvGQWLw1f5M8bD1WHgOqUagt2RyT6YKq++JD1/F/nE 83R0FLqI0ckdqN2KCJ8v9hiUVpJ7fv
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[21.51%]
X-Spam-Flag: NO

Hello,

ext4_xattr_set_entry() creates new EA inodes while holding buffer lock on the
external xattr block. This is problematic as it nests all the allocation
locking (which acquires locks on other buffers) under the buffer lock. This can
even deadlock when the filesystem is corrupted and e.g. quota file is setup to
contain xattr block as data block as syzbot has spotted. This series moves
the allocation of EA inode to happen outside of the buffer lock which is
generally more sensible and also fixes the syzbot reproducer.

Changes since v1:
* Rebased on top of Linus' tree as of March 21 - which meant dropping one
  already merged patch and reverting one as well.
* Fixed EA inode refcount leak

								Honza

