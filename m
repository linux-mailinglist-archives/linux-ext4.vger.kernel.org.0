Return-Path: <linux-ext4+bounces-13620-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNpvAdh3iGnzpgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13620-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Feb 2026 12:47:36 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE401088FD
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Feb 2026 12:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E71DD300B762
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Feb 2026 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ABD354AFA;
	Sun,  8 Feb 2026 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="iA7G9VFu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sonic301-31.consmr.mail.ne1.yahoo.com (sonic301-31.consmr.mail.ne1.yahoo.com [66.163.184.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D09533AD88
	for <linux-ext4@vger.kernel.org>; Sun,  8 Feb 2026 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770551244; cv=none; b=IX3tMR33d+3THbmbos50ID62jj/Sc7EfwOfkcC0sXq7PP6M/mR0FqGbzBxkuUj2CYSS2Db0LzK8j5KQEhbREyldWyUHzKCzHcJz+/2s5KHTVZb3Fc/oRTozYAQ4XFsyIOxnNTobtAbKwDcV3bUfhB/cFaGp4oZ5Aj2oGzFQoRus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770551244; c=relaxed/simple;
	bh=gdOfeezOnp+cIM//W2webFIr5eu68YOhZqcFXZsX8Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sgcz4LIZsktNrsx3ShdhWHQPRmBcmHJgXiVE1345IKprx+xnqVT8axIQZ6ISiXcQlQ6mltStglI+83Am60CoBHE3ANjYNzIjHUQZa18xKCOTzwPFWh6rhURe1IzTn7ScDdsos7n5udjP8SZWekuFu+zsBubjtXiy3rOF+lBqTN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=iA7G9VFu; arc=none smtp.client-ip=66.163.184.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1770551237; bh=gdOfeezOnp+cIM//W2webFIr5eu68YOhZqcFXZsX8Rk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=iA7G9VFuv/3ZaeMbTzeBA5r9ri70yQodcejo/8ysCIgaMgpAjgchWbLg+OA9/lOO2oofQDep2sbf4mN4knjAaHUuhlMvKJ/4VmH90NuKdHyxHTAdhZmKBsRejC8NnqAofB6VxbYReY2e/0uuaDRqpSpYmZNEQQbQc3LZaILZ6At2vRtnvUOD0jpukMW1Xda7c3J3zVXF7zFfmbvOWxwr3Uj0NmKmqbuf3gNRLMN+0JsIvVrXo/jyyg2Pe3mtiK1V+HBU4AIGl9Wgl4kcGFFWWSniWjqoaf6s5hRdXSdz4jTQwJhkx/FtJ2naJj1Q+16jc4nqPIP/oVaU9V6MYdZ/Ng==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1770551237; bh=PnHKQF7lASDx/Dcd8LqlvgNcpSYjrdLfhCldNpgzX4n=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=giyQg5yD9YrWgOGOCmU232KxZ5HA7u71nIT7yupnBeQ4fxLubi20FsI2+xdzxCSrHO6uJ4OO7gYZxvELdyG4NHVeSYjQzMdYpL1yyHmr1VxPSt/Tw/xwrzUdKVGw1DH47pzxln9Z3ZmbdI6a54FtvcgpzwkEcKZj/ay6oRlBfe7icmxrp2zpWaH4lqTfkA8MO/PrldaOsgmdVuqCNtdfhpjwfEFQgHsMQm8Zv5vKlKCYKSDwMcfk+dfWEVAiEPqyxeqUjoUoGJ7xovjgXy1et+65lotpMIWU5JEJtVUwkD3ec5UjBgIDMN1+833DUYtShscHKqQnk1NiRp7NOhACgw==
X-YMail-OSG: GTDrWugVM1k30GEq.uioadga.AYr9hc0kILuEJxeYhk0CXc9e0693TF4zLf1JQS
 r_Fwvt5nqLmJ7n.WVJMvLi5_8TK2bStBsv.Zavl.ZGzY_JMz.BaPR6Kku8uwq9uGkW0MaWJAy5vX
 naPJ2njxD.LVOFwbu0OwU_yae8MjfmDs2HLxQGXIINJD2tPq1YbAl6MMtJD49zK_JsgVhWSaKisL
 V9r8InzvBySy8GjE8mo0IKIeDA4SKOz0vb6hyvRJi1eLYtSZabIShgVS1uqNVIRhJ.u6uaJ.k7Gk
 RRYuOcSbNJrmNWrrsrUCUM0Y_AO7_VMpYAgBK1vFkwqpQmknvWOSOwbE3o65dx6EXnKgoL6FwLrA
 ze2HSrbsaX5Qc81BQthy8xcQ_RJaTbudi0nUYsX552n0MSRslCmbD9rr4E3aHTx9xrh7tufZieQ5
 cOvXumWCeAanzcpGkFOK1tBd97GnVrokbcUbSI5P51Qkl.H5QcSBtUBc7tbt73yAshMQbtn.Zf_6
 0r8HJSAUxb0GyZGpfomE2ZPUljWEwRbCrSlCEYubxl8iQS64J5hbeg73k7n.gdncDhgQHSLm.Fzv
 _ayoLHOk1MM12W5oociWxPOyUkcRtQ50_hwGDKytb7sdt53CMHbEms9NSJVlvSX9cBkPpdQLsddI
 uZdFRL_6kg0erZAbSCcNy9Pq2xDX.kMo6nuYTIpYVSgiIn3WjU9g7W9MVJ29j0AH2EnLwShHPzyg
 KxKbmIX4lH9Kyw2SXoO5xQ0wnpWu4kAa6w4V4BEpenvNf2Ui8trRJX2TEmuEkAg05uvDVPWFnCc4
 FsAEY_2iWkKtlMqHAhFMkSpECPVokpX5qfkdooXMaVIaVv.IBL41oMyJ6cTY.NgAcVPGl64.EJog
 PD1.g5oCe_pwamB0Xq2_WiFDjsw0lwlVLyS.xxTnthCWXp5mNEsz7H0L8DBF3KC6lvtg1PqyPPok
 iuBTxVPEdJG3PQEWyNEpradbUx1d.n1DSTzoBa3BlhvImW4DIt_TaRXW1Bcg19a6H7hIKXunTJjX
 JGGeka7BGgOrw_sh.C4N7283YZRamjQIcmZKAoYWpSnPMTpPS705kApNkzcQYDykC9kzE7dqGpYi
 MIdwHS7RMmNsOlKupn18tz3MT_Yhh8AJqZ7fxjQMimHXO1ZM4xkKLhM621ZRTy6Hc2ZhuKC7Gl7I
 mxA69YOl6M3Bqb8MkUaFVwwL6A4CR.sOYLPTmVf.NpYJW3udC.uCXe7KCYfNt3FpqB2HSdRnMCHE
 EbOEDkw2vXK4v7mNgm8c6l2HjDoSnHdi5HWr1m5fipmcInMSFNyOeqjPLB0e0n6a.WpBgrdX4VOR
 rgMkh18NSBdHdjKOcrEgnq1WNOOpsR8MfL1cbssKb99TuilnhTmWkNzPibVuK_Uy8zKy3K15dlWl
 qz1cmepRlHF6Eb16_hN4yQlMYP8FVC_NdMCK7jNXSv7msqAn0VD6lPJ8LAXxKGaKt6O9oHDntbMo
 0PnOU92EHQIv5O_x8o674VXAu45k9qZuOKRH6aikgaGrHq7LZ7VtoVfQdbKdo6p7Y4Q9T77lg61E
 xNvzHzZUhbJLMuU4cqnQhNAAPkzPs6WIh2cvygiU1ggnyZddvGKy36MfZMz7h4iesh7f6gTDb9KK
 VI4FtUDMwspYWICjqbmghtHh0Rdw3nmId2_2OxiXG8PuO_q87GtmS0DJcRn2j50CI6ZSn9_.7w1p
 rs4H4Xi9DHUiIYeJveSBsc5cOu4rEmE2ViuylYo52w3u1GRkTLg7DNQckJcVN5GWj3Rb6Y1830ZK
 6ded9fztzypr7FW7mZlZwGFTwxnfmyiuaVoMqlyiyVdTkhLzP1YR3zNJg4vJo7qW_Mi8FnYrnR_H
 n_fcRSHDM9.DM69_sct5k3wbRuP.ztFz1dEOVWi3XFnTFhK6Ho5uGIiwevoyDNzhrYKT5zITzhBp
 fvKqiMKwoJeWRITkZ1n6vnmYI9hCH1OTnoEQRKA5IKsQXm3Gl6NjI2LCdq96VZ8muk5jLryfBkwv
 VXCzjBs0zNn.02vls7nutcfuevfpA_ncOjmln8_iJ_kpC7sx8zgW.wMPNmhlrFJQEphSIOzXnKM0
 vREmGii_7LJPVuWWZyWX9DDorXdxy2hgl4aEzz4vlcIag609VY0cK6K5amJEMaH3oKx9kB8SUUb7
 .Tdk0eaWfGOCe4RaSLxsBb4Jt2b7l4rOL6RdcPW0O4UKr0xmNBaKrXbk6MI9iGamFIAPys_6ZeKb
 S3lGk_.iRp9htkQrOHh.PRsw8AC0-
X-Sonic-MF: <mario_lohajner@rocketmail.com>
X-Sonic-ID: b972287b-38bb-4fc0-bd5e-dd59a8c6199c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sun, 8 Feb 2026 11:47:17 +0000
Received: by hermes--production-ir2-6fcf857f6f-dtp6k (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aec5cb4b6d289ad96170a5ee3d1b2957;
          Sun, 08 Feb 2026 11:47:15 +0000 (UTC)
Message-ID: <9e520492-9b26-487f-9d60-7e0625c987c9@rocketmail.com>
Date: Sun, 8 Feb 2026 12:47:12 +0100
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: add optional rotating block allocation policy
To: Theodore Tso <tytso@mit.edu>
Cc: Baokun Li <libaokun1@huawei.com>, adilger.kernel@dilger.ca,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yang Erkun <yangerkun@huawei.com>, libaokun9@gmail.com
References: <20260204033112.406079-1-mario_lohajner.ref@rocketmail.com>
 <20260204033112.406079-1-mario_lohajner@rocketmail.com>
 <c6a3faa7-299a-4f10-981d-693cdf55b930@huawei.com>
 <069704a4-2417-470a-bf32-0ee3afd1be6a@rocketmail.com>
 <9fc3443b-0eea-4917-909b-709113f5e706@huawei.com>
 <606941c7-2a0d-44c7-a848-188212686a78@rocketmail.com>
 <20260206014249.GH31420@macsyma.lan>
 <26d60068-d149-4c53-a432-8b9db6b7e6a5@rocketmail.com>
 <20260207053106.GA87551@macsyma.lan>
 <16f17918-9186-4416-bbde-b93482933d8b@rocketmail.com>
 <20260207175522.GB87551@macsyma.lan>
Content-Language: hr
From: Mario Lohajner <mario_lohajner@rocketmail.com>
In-Reply-To: <20260207175522.GB87551@macsyma.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25178 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rocketmail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[rocketmail.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rocketmail.com:+];
	FREEMAIL_CC(0.00)[huawei.com,dilger.ca,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13620-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario_lohajner@rocketmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[rocketmail.com]
X-Rspamd-Queue-Id: 2FE401088FD
X-Rspamd-Action: no action

My review of our debate boils down to this UX image:

You provided excellent facts, articles, knowledge, and insights about
the design of systems around us. That is our reality frame -there is no
point in denying any of it.
That makes it a very powerful lever, a tool - let’s call it "a spoon",

Now, someone has a different dish on the table, and they really need
"a fork".
Instead of giving them the fork, we hand them a very powerful and rigid
spoon and say:
“Listen, here is a spoon. Try bending it a little and it should work!”

Someone comes forward with a fork, saying:
“Here is 'my fork'. I believe it may work well for 'some dishes'.”

I'm *really not* trying to bend the spoon here,
I *could* be asking if there is a spoon at all, but,
instead; I am simply showing you my fork, considering if it can be
helpful with some dishes.

 From that moment on, every discussion about "the spoon", of the
future and the past, condenses to this statement:
“Oh, 'the spoon' doesn’t work very well for you?
That’s fine - here's 'a fork'. Try using that for 'your dish'.”

Is the fork strictly essential? — maybe not, but it’s a valid option
that makes life a little easier for many of us.
Can you hurt yourself with a fork more easily? — maybe so; some care
and understanding are required
(hence disabled by default!)

Signing off,
manjo

If all you have is a hammer, everything looks like a nail.
(...fingernail included?!)

