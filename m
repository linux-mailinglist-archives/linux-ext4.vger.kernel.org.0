Return-Path: <linux-ext4+bounces-13337-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJtpAMjkd2k9mQEAu9opvQ
	(envelope-from <linux-ext4+bounces-13337-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jan 2026 23:03:52 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 780018DCDD
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jan 2026 23:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64128302290C
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jan 2026 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3312FF67F;
	Mon, 26 Jan 2026 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Puk6Va9w"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3712FF148
	for <linux-ext4@vger.kernel.org>; Mon, 26 Jan 2026 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465029; cv=pass; b=Rid7B/jZjwlVz40PEpz1NF0RhrYYSeA8/XyKqWhoH657/5Tc+ynYBQGKH9x5wZ8w4jotdvz1fCSHtEvjGy2qYlScEdA6SZmem/4+lbCTATMzafzzBU0vLbJH8NqfYsLX6vqO3ycRDjF3J+YYRHDTn6v/1wtUMc7Qrbx19E8X4Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465029; c=relaxed/simple;
	bh=vBeV35fwku9CnFe/OmA75ZrHPb5195tw3FhVtWb96Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAjJA/67RBwpkvlE/ae2TEWFhMXlgxz1s1eqSmV0eTeyUrW0XAnbQyU+vlNptynkF3km0pduENRJyKu2xoW6Jx2aojUB75v4asFHOe49nxwHRFYq+pT0EjVS58PkfvpZArOBWctFU/mzwiGLptFXYzuS2411GYzXJuwQvjzpaAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Puk6Va9w; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014b7de222so60791031cf.0
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jan 2026 14:03:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769465027; cv=none;
        d=google.com; s=arc-20240605;
        b=BPoQSDj40fng8APIkq2x9/NrTSJJAPpv7dHCBnAv+mtgzFoVvX+wyCCDs3pyR/uoQj
         ZU2OF2TLFA3iz+dfvYzUaH0SPXm6oQC/OJHRcNEVrfvxIkTi4YnrXg307id80sten2Ww
         P3BfzDrX2eRsJXmngl0FxP/n8/m4kNUQGdg8gVTyi7xRQvLzfhnfmfMoeD8EksTjZ5Ew
         tHx5b/WiomD0m2w7AnDDQNn+478sLWhmRqqbfGnLRPvrQq9+Bjb0v3o9/F/g6P76tZUe
         IXUUjMLGqc8Nl/iQQCbPDRKMHcLqMxS+X9ZFfIn2g0hGOyBWk5ucBYuPian7BxFq84Dp
         2uhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0GQz5BrunN5+AVpEKL3s+TGSO56ZaLfAgrBKITYepc=;
        fh=BF59n+rLsoBJGkTFHLQqnRN0KCHUlgvBGXjzw9xFTMo=;
        b=LyMLP90ZvA3oF2TtoRIaw4xEavyg+KD2w2uivoUctjWYPSSHNRTcDGCvHHIbo5KFLb
         OyNQCH8ungZRjITLxs+ZxsR0rqVFRbQ+4HJ+q6fcW0BAanTldICzfl658+UPNSxH/8Sq
         FDEFWCnBI0LRPTFPCcVCixTQ4AXD1JCL4/6kistB0pFR+rXwZ9dIsxGjWLRA0OJ/FTgJ
         RVnduvz+ZBo/xBYk7+56fmVpkyzMz/jRBdvKxtE8mF21eF0Adw6pO5cN4sKwypXq8N64
         5d+6OsOmV4kpsGlCVOt7Q6FrQ+6qjJYLsznKGWh/9aPzoZjUu+nzQBxebDTZIl9KOP3Q
         sLrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769465027; x=1770069827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0GQz5BrunN5+AVpEKL3s+TGSO56ZaLfAgrBKITYepc=;
        b=Puk6Va9wl4NqmsOAmOdrkFQkn3AR21ONpytTHOViyZgzofVONMfJtQ2rj3Z8VoQdYZ
         2fZsXxTycFVI9kd27oy5SQVicje2zJ4eaZY2X5t3JkW7HVDazyvVNthm85MDZ2BXbpa3
         R7ULJL4wBlGpqCH13ESIsZgVPhXmlFZNKV7FdtvkBNc5E/BRmrYKN9ZuCSnbDU9UztFO
         KkxmKoYhdtUxe5qOXa4PM74PF5lD8WoZZZoEW/OYSvsobsyrJCEpkoBPVc5Nk3GK47Is
         ojLz1MRcW6jW0WZD+35GOWgUvxYfJJNPnmVaPLayIoqRfOcwsiGfyXPFs/HGzI55QCBS
         FqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465027; x=1770069827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U0GQz5BrunN5+AVpEKL3s+TGSO56ZaLfAgrBKITYepc=;
        b=sPF/MCSGFHsQnGbNe3K+PCRqAPH1PWp6erTZYJNbZwTx8O8UNzW2e7sA6WzSrmj3oJ
         Gtyy0E2abVTpS0wFw4JtsEN/GUVYbjUwxq4rAzWy+OblrXD1SFjzRRJxYXFZVImY5df9
         M+lmjnq34s21kGpHcNY67xsmy2secs48C8JmM4hCk/o4wNXisIpul4KQxPScRiTEcYlv
         y/q/CC2X/6ZuPVjR9XC2+gyGWn8Qov4dc7bRARxCAteP059fPoz1K+2uRwNysmqUsB+z
         Qk+w76b2XxmIzhL/n1qOOo3Z86X+Xhqfp1FYZtHxUgK0d16i5cBwmJrWdj6cD0Ht3EbS
         9ZQw==
X-Forwarded-Encrypted: i=1; AJvYcCXpMg9aOdsZMu5sm1Aanpvwe5qebT3exUvlGQv6o+b+WSYwHBIUlGxJxnNbjzvHBPewhfolKOnQyd6z@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVLM7cxVRzUaMwCjWVhvjV5W+0LhmHpkMCCA133hJIp7kA99y
	QbZFZ8CnLfKIqLZk/V/NMlu0JeipMQ4VFzJPS/akzOLHirlIRFS6O0De6eJ5P6iRcJOe9sVFPCx
	AlXxOQkZPQt4JICPt09mqqjX7xUVxS4k=
X-Gm-Gg: AZuq6aI9GVtxTZdz7nhzXicABwN/sXHLKeSkS0Iidm70o+W6zyqnVFyJ8OE9OfKRc6Y
	XFLFK14M4am0M9rLnJydEA6LhlJCZG8veJ6deYPG5naXTS+NL2OWxnTyB2nd9Z4Lda504rdX25/
	fUQuSipLZ1L7s/rwg/VzNksX0FLSZfuTEDazKCTZuhHC9hXihhxWicFF/OJ+sBXm11bXnBq9RWW
	nWUMFSaRb8+F5edInMdrKNYzXzy4bhnD+3EOgz+NAlzUu1jCes1z1/OWF8WEW+HN6oeWxvJMUUy
	r8Nrz4YuYVs=
X-Received: by 2002:ac8:7e93:0:b0:4ec:f56c:afa5 with SMTP id
 d75a77b69052e-50314bad868mr71172071cf.22.1769465026709; Mon, 26 Jan 2026
 14:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810721.1424854.6150447623894591900.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810721.1424854.6150447623894591900.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 26 Jan 2026 14:03:35 -0800
X-Gm-Features: AZwV_Qgm806vibKtJMMyXSlZpA5lFonExx42bXZM330YeqybgAAy-pL4OxB8GVg
Message-ID: <CAJnrk1ZDz5pQUtyiphuqtyAJtpx23x1BcdPUDBRJRfJaguzrhQ@mail.gmail.com>
Subject: Re: [PATCH 17/31] fuse: use an unrestricted backing device with iomap
 pagecache io
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13337-lists,linux-ext4=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 780018DCDD
X-Rspamd-Action: no action

On Tue, Oct 28, 2025 at 5:49=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> With iomap support turned on for the pagecache, the kernel issues
> writeback to directly to block devices and we no longer have to push all
> those pages through the fuse device to userspace.  Therefore, we don't
> need the tight dirty limits (~1M) that are used for regular fuse.  This
> dramatically increases the performance of fuse's pagecache IO.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/file_iomap.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
>
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> index 0bae356045638b..a9bacaa0991afa 100644
> --- a/fs/fuse/file_iomap.c
> +++ b/fs/fuse/file_iomap.c
> @@ -713,6 +713,27 @@ const struct fuse_backing_ops fuse_iomap_backing_ops=
 =3D {
>  void fuse_iomap_mount(struct fuse_mount *fm)
>  {
>         struct fuse_conn *fc =3D fm->fc;
> +       struct super_block *sb =3D fm->sb;
> +       struct backing_dev_info *old_bdi =3D sb->s_bdi;
> +       char *suffix =3D sb->s_bdev ? "-fuseblk" : "-fuse";
> +       int res;
> +
> +       /*
> +        * sb->s_bdi points to the initial private bdi.  However, we want=
 to
> +        * redirect it to a new private bdi with default dirty and readah=
ead
> +        * settings because iomap writeback won't be pushing a ton of dir=
ty
> +        * data through the fuse device.  If this fails we fall back to t=
he
> +        * initial fuse bdi.
> +        */
> +       sb->s_bdi =3D &noop_backing_dev_info;
> +       res =3D super_setup_bdi_name(sb, "%u:%u%s.iomap", MAJOR(fc->dev),
> +                                  MINOR(fc->dev), suffix);
> +       if (res) {
> +               sb->s_bdi =3D old_bdi;
> +       } else {
> +               bdi_unregister(old_bdi);
> +               bdi_put(old_bdi);
> +       }

Maybe I'm missing something here, but isn't sb->s_bdi already set to
noop_backing_dev_info when fuse_iomap_mount() is called?
fuse_fill_super() -> fuse_fill_super_common() -> fuse_bdi_init() does
this already before the fuse_iomap_mount() call, afaict. I think what
we need to do is just unset BDI_CAP_STRICTLIMIT and adjust the bdi max
ratio? This is more of a nit, but I think it'd also be nice if we
swapped the ordering of this patch with the previous one enabling
large folios, so that large folios gets enabled only when all the bdi
stuff for it is ready.

Thanks,
Joanne

>
>         /*
>          * Enable syncfs for iomap fuse servers so that we can send a fin=
al
>

