Return-Path: <linux-ext4+bounces-14462-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLZVJA0bpmmeKQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14462-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 00:19:41 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D87A1E6837
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 00:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAE6F300DF76
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 23:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4B32D452;
	Mon,  2 Mar 2026 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="VnDncOax"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48731F98F
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772493574; cv=none; b=MPwdj0xhJqsVfXiFMTdx7gz5H417fqVjPQFn2lhQnyLjl7PqQA8IY4oAjp3GBms+l9DpVd/fJUUzm/HmYrFQjEDEoQfNFCPhIoxC9IMc3EygKL8pAdxpLXJI+bILPqtsGvWf5xEgv9BxzY5qHQ1XcccKDJSTKQapQ96qlNO9PBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772493574; c=relaxed/simple;
	bh=eXr/PzWfrTs+Wi9rGVzIGPHTIGVzUFI+7QB4e0NMKWs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DRAY4BGyMO70JTLYUCQVBYNXzOuiDFqlYyQnErlpQKF8rLSCzf004E8WO1TXbumi3YJe0XPVktIon/RJ7BUEuk1Dfm5VnWr4Ueazu9uRvoWJOyjB5J0HmzeP07jDJtGb8pa9yFaeAL7soY9bZwu+GXV8sPnay6RIMVkhuDbHPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=VnDncOax; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so1047005a12.3
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 15:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1772493572; x=1773098372; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxXB3wUYYrve7SfxR7HxYha6g9dlm49vwehqb6Z8vrQ=;
        b=VnDncOaxfkamnJxrqcHCvq5cVEHReCQMZ0dKUyxOxdQ1Xo2VjcG3vC4W3iAoRT4vuW
         tUOJO4WFjJvtP9psJzGWfzrNIZ3IKq0INH5GnkzUHcIXRmxarzzEF34lL14Tu6+xNgy+
         DT9Im/ZrRntfUTBYUe2ffxKERvAMqugynrFaYZNxcMARYE3ZTl5AfAFwTgh/WzK4iMWU
         KO7b6gYkR5oelrO8Zg1K9oitt8V+cavEbAsaCnegk0HgFeBGa3rzTS59A1ucvjJK9v1h
         Cky9QkNSfhaPNNLMn42QPkrabsFlJyww5f1ELZbOJ8N2sVRxvHV7Jdu58u0s8d9wtgH5
         f11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772493572; x=1773098372;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxXB3wUYYrve7SfxR7HxYha6g9dlm49vwehqb6Z8vrQ=;
        b=B10u5Sf4UmCTkMn+vFdTE5NVasV1EtyldXjLKd8WMGBjL3x7Ke6OrTdy6Xamk2+QVI
         k7A5ipuHBb1Zy7h4E5ClZpzH8F4P9R/UPP34xALDzX9FgxKqgT4qm/b0IdlSgTFeLZ//
         swdc/Ac8KPJOa+Sch1guBrApINrQV1u/eX6h87jjZjyttjb2Szg8MQtOWdajiL0+zA5a
         9pMRS2FYqzvGwTPxZNweENdOrn8u7l/1MCFX7idaEzZBenxd8MBSZFuqh2tS9zfTAqG0
         ByBPRSsgIaGoibwRpD2vcEmfJ9kDgIDrEdVJpQ+yJrrQqEFkGGbCz/Oyq/8wIkvRh7hn
         MYEA==
X-Forwarded-Encrypted: i=1; AJvYcCVQCcwxOGPBlyiDgVumeHhTcr4IDJt/kAswR0zc5lqm4dOy6bX9c8iGUv5LiTzZqPMzH0j0PskubKnj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr04cUdrgDuOTAe9sIIKzxThNJtC1ZpsmEi72G3ElbsfoisNEg
	Yg7AAX5Sm8DKAdRUs8UEw4MQBX3Nc5wjSCEq4l2seHXBPOyNhdbcCQF2bKNUe6IVEQ8=
X-Gm-Gg: ATEYQzwvoMjiVroHe5LggGjGx/dAghsecO6651mENXkpYrcktPaxR673/Q2g9SBY27p
	YmJqmOtKetDijG5R/3a+teQ0QmC2bN1mcPUKfT05CrkqTCW/j2KM0ZaYrMNutodcOG6lU562eKP
	eqI04Tqfx0zBBJyPGWUH2q2U5lEqYTEaJVFl8yySRq3DrC4UdyBQctnjTiPkBFOEOezdzLbXjHM
	c059uHQp+IIPOd45hEgOoFuyL7i4VzxpiopravCCAFMBlHn0SUUVFuZ1qh3hMlY78czUgBIjkUg
	hKjpIx3FZkApkpftoge9ULOXi1ZLivae+3MGg1Td8L/jACYpqqDaANujzBnfkgKxAJ8gKoKoEZp
	e+KqSpcvPe17bSHEr8z//3tNZdAcLu8JOdqYhxwqHBGpw2Hxc1/uINBxjBytWUfVkq/V8mJNl5F
	oy6xKZnOH76X0jpECg8y5+tZx8JNXflZjSsmwN765VuDy17gur/E5nfL6vJSnukGISNO8aYqfKq
	kp/NYrZRdXUTOh/
X-Received: by 2002:a17:903:2442:b0:2ae:4f2b:9263 with SMTP id d9443c01a7336-2ae4f2b949cmr60382425ad.40.1772493571918;
        Mon, 02 Mar 2026 15:19:31 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8293c29add8sm6287182b3a.19.2026.03.02.15.19.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 15:19:31 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v2 2/2] jbd2: gracefully abort on transaction state
 corruptions
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260302213425.273187-3-nikic.milos@gmail.com>
Date: Mon, 2 Mar 2026 16:19:20 -0700
Cc: jack@suse.cz,
 tytso@mit.edu,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9CA1DBA2-9EFA-420F-8C58-2AD48E961D44@dilger.ca>
References: <20260302213425.273187-1-nikic.milos@gmail.com>
 <20260302213425.273187-3-nikic.milos@gmail.com>
To: Milos Nikic <nikic.milos@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Queue-Id: 7D87A1E6837
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14462-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MSBL_EBL_FAIL(0.00)[nikicmilos@gmail.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,dilger.ca:mid,dilger.ca:email,dilger-ca.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Mar 2, 2026, at 14:34, Milos Nikic <nikic.milos@gmail.com> wrote:
> 
> Auditing the jbd2 codebase reveals several legacy J_ASSERT calls
> that enforce internal state machine invariants (e.g., verifying
> jh->b_transaction or jh->b_next_transaction pointers).
> 
> When these invariants are broken, the journal is in a corrupted
> state. However, triggering a fatal panic brings down the entire
> system for a localized filesystem error.
> 
> This patch targets a specific class of these asserts: those
> residing inside functions that natively return integer error codes,
> booleans, or error pointers. It replaces the hard J_ASSERTs with
> WARN_ON_ONCE to capture the offending stack trace, safely drops
> any held locks, gracefully aborts the journal, and returns -EINVAL.
> 
> This prevents a catastrophic kernel panic while ensuring the
> corrupted journal state is safely contained and upstream callers
> (like ext4 or ocfs2) can gracefully handle the aborted handle.
> 
> Functions modified in fs/jbd2/transaction.c:
> - jbd2__journal_start()
> - do_get_write_access()
> - jbd2_journal_dirty_metadata()
> - jbd2_journal_forget()
> - jbd2_journal_try_to_free_buffers()
> - jbd2_journal_file_inode()
> 
> Signed-off-by: Milos Nikic <nikic.milos@gmail.com>

Looks good, though a minor suggestion for some of the replacements.
 
Reviewed-by: Andreas Dilger <adilger@dilger.ca <mailto:adilger@dilger.ca>>

> @@ -1069,13 +1076,24 @@ do_get_write_access(handle_t *handle, struct 
>  	JBUFFER_TRACE(jh, "owned by older transaction");
> -	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
> -	J_ASSERT_JH(jh, jh->b_transaction == journal->j_committing_transaction);
> +	if (WARN_ON_ONCE(jh->b_next_transaction ||
> +			 jh->b_transaction !=
> +			 journal->j_committing_transaction)) {
> +		spin_unlock(&jh->b_state_lock);
> +		error = -EINVAL;
> +		jbd2_journal_abort(journal, error);
> +		goto out;
> +	}

In cases like this where you are checking multiple conditions in a
single WARN_ON_ONCE() it isn't possible to know which condition
failed.  It would be better to add a pr_err() in the failure case to
print b_next_transaction, j_committing_transaction, and b_transaction
so it is easier to debug if this is ever hit.

Cheers, Andreas


