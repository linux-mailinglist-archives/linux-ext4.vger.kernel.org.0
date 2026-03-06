Return-Path: <linux-ext4+bounces-14686-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPIxA4K3qmkiVwEAu9opvQ
	(envelope-from <linux-ext4+bounces-14686-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 12:16:18 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F38421F882
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 12:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08D1930488E3
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4313E3630A6;
	Fri,  6 Mar 2026 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="NR8dMX02"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9732F748
	for <linux-ext4@vger.kernel.org>; Fri,  6 Mar 2026 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795774; cv=none; b=drROowgQO5WX+pkBiHGsuNs9Kpaz+Jb1H/uIcIs8uQTlCHPm5wbjC1xcO/JaBuQX6tGsepxujU3xqkVgvbppOP3Z3eplUSvnHiBcUgXlnZJY/noG/DdE9K9hOhi2vBLclge3+9fCORMMMyqEUytKFwtotFNhyCirh1bK4Xj6/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795774; c=relaxed/simple;
	bh=mv/RHve6D2xvhbuvCKOwfz3uc+PVsrnRe5rvLcPbLog=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nOW9DlT9hwVSDfIEcAY9Nvkvth2oXiGi9gPG+2GRBiVAjC7w0tbiUV3/AtWRZefcx4qxBtMJa04xYfX1rX+dWWsVI4bUye7qPucRtTBWq+4NYfmDxZdHnn2MXljTxkS0TsMSLudcuj+wkUF8NyV3jDv+kj1ccOJkrp0o5Q8VnwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=NR8dMX02; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-829ac8d56c5so38429b3a.3
        for <linux-ext4@vger.kernel.org>; Fri, 06 Mar 2026 03:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1772795772; x=1773400572; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MB1vOMP+Nolx+MoTaN64094W5fQe56/R4b51YXJC8I8=;
        b=NR8dMX02rG2ILtA/MW3OKgJdNu9GcaJ/5o6EXK3wBkdRq89oPqVLVUydDrYdBYi9Sm
         sWlXNt61KFNAa98IrXtkc/KzM+fDkDJPIeVrkeWkwinUHtu5eEB8xmeHLbisastnD3/y
         VHtinC9b/ml/fSU5zr64x6RukrOcDyZ/w7lShmRdd+ec9PEzHkQmDrxFxqhKBzjNmTV0
         WkENdQes2lZ9d1NI4n5N7ViQXHKcH7sCfYN7Q8+z1t7Oz4lMJghrupRdtMI1rQM1VGhZ
         tAxH6kg9cJtLNuSoHfMIPpRMFJR8V7qA/nY/tdI6FuLaB8P0Y8zNkFA+CdVUCKT+Vocv
         nRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772795772; x=1773400572;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MB1vOMP+Nolx+MoTaN64094W5fQe56/R4b51YXJC8I8=;
        b=ui/WT6lJ5AZ/JWuti8sCoJtiHjGMUe6fpaI4cjkjLh8etxXeETeGhTzpJ1iyiRKs0I
         EkZHc73/bkRNsldg9KGnQW+rnFmR5318Qx4QrWF+bsiKpy12LfbFFSXInuCP/cwJb9md
         jd4HEsptrjrdidF5rKmOLn77sgN8Od4wAHwNB472qdl+b1X060lTxo6KOeT8fuW2/A8F
         3er5gaJXwKFfKxSJlWLkzF1KlTSvsoQ3I32oP1B2fR+wMKp70c96CV0Qve+unxAg0HOK
         BJnRl7WexApqo/fpn/fz1yySxjLWF8bBm+65pqzywP5yETo4XDQ1HTnmjxZUzL3Q9XEZ
         tgPQ==
X-Gm-Message-State: AOJu0Ywp7K+1vnKqE+FSLqA/fiqTnskv9P725PUVDClaE7lUOpRf8Zzz
	oxaMx8tnHZhy6QQ1ZqhYKZiE4hNXNtQs64AntaE/YuXWIDo4lY++vOH2a1za5FPWhX4=
X-Gm-Gg: ATEYQzwcrR8NvNZH9gMoWZdoyRWu5JAAA5NOpIXTyyCbZLp0WjSbG76vTs8+5zF2I8b
	Xt4z+cfLWpcWwM2sp1fbDoriNxjacRmgxD+j+JkcpwCisOIJULbReLvjytXHr/E78PVVJHyf57x
	GS9UuuLBoVcAw9HNSqaCDiWztyw2XJmQsBCfTe+Qh9O4HpdD+ElJS2/3G4VljRIy8MTwvO2Y2OB
	JHXpoVx6UhsXLVW6Pc+bQd0cPpwehkGTNB1SOL1yBbWeURXHtoIyS5b95hrdyo0tQd9nNKCLM4p
	6/Q0O6CuHst+KfYh2WOTiJ1NDqlTePJecXFTeaX5nlplojT2/B5B/wfpc0gsqp17ek55mu15zB/
	+J5isgwYlbYBjsDL9UmAgyQPfK8a3O62sWhqOjkrrPW9YMEj6WlQl1XhfRBwcIlqm4L9YdhIcYq
	yMLFcsVBB72qW/IZt2pFXmId/sWUUXJcEJQhY02H+QgLDeYwevjfitoOpD/ZKjCAHmHpU5BE2IF
	Pes8g==
X-Received: by 2002:a05:6a00:1d9f:b0:829:9a7b:db84 with SMTP id d2e1a72fcca58-829a2f319d6mr1563257b3a.49.1772795772482;
        Fri, 06 Mar 2026 03:16:12 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48647e8sm1524999b3a.33.2026.03.06.03.16.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2026 03:16:11 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH e2fsprogs] e2fsck: preen inline data no attr
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <3188418.mvXUDI8C0e@daniel-desktop3>
Date: Fri, 6 Mar 2026 04:16:00 -0700
Cc: linux-ext4@vger.kernel.org,
 Theodore Tso <tytso@mit.edu>,
 "Darrick J. Wong" <djwong@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEC84F37-1DE2-48D2-B9C2-40E3A6FE8451@dilger.ca>
References: <3188418.mvXUDI8C0e@daniel-desktop3>
To: Daniel Tang <danielzgtg.opensource@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Queue-Id: 5F38421F882
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14686-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mar 4, 2026, at 06:56, Daniel Tang <danielzgtg.opensource@gmail.com> =
wrote:
>=20
> I don't like being forcibly dropped into an emergency shell to =
truncate
> pidfiles and other temporary files every time my tablet uncleanly =
shuts
> down.
>=20
> This seems safe. The only thing that should be erased is the size.
> The removed inline data flag is remembered by the extent flag being
> absent. There is no data to lose because there are no extents/blocks,
> and the system.data attribute is already diagnosed missing.
>=20
> Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
> Link: https://github.com/tytso/e2fsprogs/pull/268

This seems pretty safe.

Reviewed-by: Andreas Dilger <adilger@dilger.ca =
<mailto:adilger@dilger.ca>>

> ---
> e2fsck/problem.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/e2fsck/problem.c b/e2fsck/problem.c
> index e433281f..e6f055f2 100644
> --- a/e2fsck/problem.c
> +++ b/e2fsck/problem.c
> @@ -1170,7 +1170,7 @@ static struct e2fsck_problem problem_table[] =3D =
{
> { PR_1_INLINE_DATA_NO_ATTR,
>  /* xgettext:no-c-format */
>  N_("@i %i has INLINE_DATA_FL flag but @a not found.  "),
> -  PROMPT_TRUNCATE, 0, 0, 0, 0 },
> +  PROMPT_TRUNCATE, PR_PREEN_OK, 0, 0, 0 },
>=20
> /* Special (device/socket/fifo) file (inode num) has extents
> * or inline-data flag set */
> --=20
> 2.51.0
>=20
>=20
>=20
>=20
>=20


